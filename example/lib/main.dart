import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_and_open_url/share_and_open_url.dart';

void main() {
  runApp(const MyApp());
}

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
