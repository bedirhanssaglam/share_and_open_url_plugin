# share_and_open_url

`share_and_open_url` provides functionality for sharing text and opening URLs. It allows users to easily share content and quickly access web links.

## Table of contents

- [Platforms](#platforms)

- [Installation](#installation)

- [Import](#import)

- [Usage](#usage)

- [Screenshots](#screenshots)

- [License](#license)

### Platforms

✅ Android (Kotlin)

✅ iOS (Swift)

### Installation

```yaml                    
dependencies:
  share_and_open_url: ^0.0.4              
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
  <img src="https://github.com/bedirhanssaglam/share_and_open_url_plugin/assets/105479937/e7aff276-e9ba-4253-a2bc-bd079ca7d59e" width=150" />
  <img src="https://github.com/bedirhanssaglam/share_and_open_url_plugin/assets/105479937/6147174e-eab1-4784-982a-fe2269bdbd63" width="150" />
  <img src="https://github.com/bedirhanssaglam/share_and_open_url_plugin/assets/105479937/128a01fb-ab41-4654-9bbf-31ebe1ce746b" width=150" />
  <img src="https://github.com/bedirhanssaglam/share_and_open_url_plugin/assets/105479937/ac7af669-4410-42c7-b454-d6f2a3dd8cfb" width="150" />
</p>


## License

MIT