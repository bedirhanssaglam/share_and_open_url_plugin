# share_and_open_url_plugin

A Flutter plugin for sharing text and opening URLs.

### Platforms

✅ Android (Kotlin)

✅ iOS (Swift)

### ShareAndOpenUrlPlugin.kt

```kotlin
class ShareAndOpenUrlPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var shareAndOpenUrlPluginService: ShareAndOpenUrlPluginService

  override fun onAttachedToEngine(
      @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  ) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, ShareAndOpenUrlConstants.METHOD_CHANNEL_NAME)
    channel.setMethodCallHandler(this)
    val context = flutterPluginBinding.applicationContext
    shareAndOpenUrlPluginService = ShareAndOpenUrlPluginService(context)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      ShareAndOpenUrlConstants.METHOD_SHARE_TEXT -> {
        val text = call.argument<String>("text")
        if (text.isNullOrEmpty()) {
          result.error(
              ShareAndOpenUrlConstants.ERROR_INVALID_ARGUMENT,
              "Text argument is missing or invalid",
              null
          )
          return
        }
        shareAndOpenUrlPluginService.shareText(text!!)
        result.success(null)
      }
      ShareAndOpenUrlConstants.METHOD_OPEN_URL -> {
        val url = call.argument<String>("url")
        if (url.isNullOrEmpty()) {
          result.error(
              ShareAndOpenUrlConstants.ERROR_INVALID_ARGUMENT,
              "URL argument is missing or invalid",
              null
          )
          return
        }
        shareAndOpenUrlPluginService.openUrl(url!!)
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
```

### ShareAndOpenUrlPlugin.swift

```swift
// MARK: - ShareAndOpenUrlPluginProtocol
protocol ShareAndOpenUrlPluginProtocol {
    func shareText(_ text: String)
    func openURL(_ url: URL)
}

extension ShareAndOpenUrlPluginProtocol {
    func shareText(_ text: String) {
        guard !text.isEmpty else {
            print("Error: Text is empty.")
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }

    func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - ShareAndOpenUrlPlugin
public class ShareAndOpenUrlPlugin: NSObject, FlutterPlugin, ShareAndOpenUrlPluginProtocol {
    // Method names
    private enum Method {
        static let shareText = "shareText"
        static let openUrl = "openUrl"
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "share_and_open_url", binaryMessenger: registrar.messenger())
        let instance = ShareAndOpenUrlPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Method.shareText:
            guard let arguments = call.arguments as? [String: Any],
                  let text = arguments["text"] as? String else {
                result(FlutterError(code: "invalid_arguments", message: "Text argument is missing or invalid", details: nil))
                return
            }
            shareText(text)
            result(nil)
        case Method.openUrl:
            guard let arguments = call.arguments as? [String: Any],
                  let urlString = arguments["url"] as? String,
                  let url = URL(string: urlString) else {
                result(FlutterError(code: "invalid_arguments", message: "URL argument is missing or invalid", details: nil))
                return
            }
            openURL(url)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
```

### Installation

```yaml                    
dependencies:
  share_and_open_url:
   git:
    url: https://github.com/bedirhanssaglam/share_and_open_url_plugin
    ref: main              
```           

### Usage

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
      await _shareAndOpenUrlPlugin.openUrl("https://flutter.dev/");
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: "Failed to open url: '${e.message}'.");
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

### Screenshots

<p float="left">
  <img src="/documentation/share_text.png" width=250" />
  <img src="/documentation/open_url.png" width="250" />
</p>
