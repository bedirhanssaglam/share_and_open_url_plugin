import 'share_and_open_url_platform_interface.dart';

class ShareAndOpenUrl {
  Future<void> shareText(String text) {
    return ShareAndOpenUrlPlatform.instance.shareText(text);
  }

  Future<void> openUrl(String url) {
    return ShareAndOpenUrlPlatform.instance.openUrl(url);
  }
}
