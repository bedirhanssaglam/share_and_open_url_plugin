# share_and_open_url

A Flutter plugin for sharing text and opening URLs.

### ShareAndOpenUrlPlugin.kt

```kotlin
/** ShareAndOpenUrlPlugin */
class ShareAndOpenUrlPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(
      @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  ) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "share_and_open_url")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "shareText" -> {
        val text = call.argument<String>("text")
        if (text != null) {
          shareText(text)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Text argument is missing or invalid", null)
        }
      }
      "openUrl" -> {
        val url = call.argument<String>("url")
        if (url != null) {
          openUrl(url)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "URL argument is missing or invalid", null)
        }
      }
      else -> result.notImplemented()
    }
  }

  private fun shareText(text: String) {
    val intent = Intent(Intent.ACTION_SEND)
    intent.type = "text/plain"
    intent.putExtra(Intent.EXTRA_TEXT, text)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    val chooser = Intent.createChooser(intent, null)
    chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    val context = flutterPluginBinding.applicationContext
    context.startActivity(chooser)
  }

  private fun openUrl(url: String) {
    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    val context = flutterPluginBinding.applicationContext
    context.startActivity(intent)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
```

### ShareAndOpenUrlPlugin.swift

```swift
/// MARK: - ShareAndOpenUrlPlugin
public class ShareAndOpenUrlPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "share_and_open_url", binaryMessenger: registrar.messenger())
        let instance = ShareAndOpenUrlPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "shareText":
            if let arguments = call.arguments as? [String: Any],
               let text = arguments["text"] as? String {
                shareText(text)
                result(nil)
            } else {
                result(FlutterError(code: "invalid_arguments", message: "Text argument is missing or invalid", details: nil))
            }
        case "openUrl":
            if let arguments = call.arguments as? [String: Any],
               let urlString = arguments["url"] as? String,
               let url = URL(string: urlString) {
                openUrl(url)
                result(nil)
            } else {
                result(FlutterError(code: "invalid_arguments", message: "URL argument is missing or invalid", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// MARK: - Private Methods

    private func shareText(_ text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    private func openUrl(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
```

### Usage

```dart
final class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ShareAndOpenUrl _shareAndOpenUrlPlugin = ShareAndOpenUrl();

  Future<void> _shareText() async {
    try {
      await _shareAndOpenUrlPlugin.shareText("Hello from Flutter!");
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: "Failed to share text: '${e.message}'.");
    }
  }

  Future<void> _openUrl() async {
    try {
      await _shareAndOpenUrlPlugin.openUrl("https://www.google.com.tr/?hl=tr");
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: "Failed to share text: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _shareText,
                child: const Text('Share Text'),
              ),
              ElevatedButton(
                onPressed: _openUrl,
                child: const Text('Open URL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
