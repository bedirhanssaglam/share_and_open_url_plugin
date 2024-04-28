import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_and_open_url_platform_interface.dart';

/// An implementation of [ShareAndOpenUrlPlatform] that uses method channels.
class MethodChannelShareAndOpenUrl extends ShareAndOpenUrlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('share_and_open_url');

  /// Invoke the platform method to share text.
  @override
  Future<void> shareText(String text) {
    return methodChannel.invokeMethod('shareText', {'text': text});
  }

  /// Invoke the platform method to open a URL.
  @override
  Future<void> openUrl(String url) {
    return methodChannel.invokeMethod('openUrl', {'url': url});
  }
}
