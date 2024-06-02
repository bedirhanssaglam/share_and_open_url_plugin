import 'package:share_and_open_url/share_and_open_url_platform_interface.dart';

class MockShareAndOpenUrlPlatform extends ShareAndOpenUrlPlatform {
  String? lastSharedText;
  String? lastOpenedUrl;

  @override
  Future<void> shareText(String text) async {
    lastSharedText = text;
  }

  @override
  Future<void> openUrl(String url) async {
    lastOpenedUrl = url;
  }
}
