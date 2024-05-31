library share_and_open_url;

import 'share_and_open_url_platform_interface.dart';

/// The [ShareAndOpenUrl] class provides an interface to share text and open URLs
/// using platform-specific implementations.
class ShareAndOpenUrl {
  /// The [shareText] method is used to share the given text.
  ///
  /// This method calls the platform-specific [ShareAndOpenUrlPlatform] class's
  /// [shareText] method.
  ///
  /// * [text]: The text to be shared.
  Future<void> shareText(String text) => ShareAndOpenUrlPlatform.instance.shareText(text);

  /// The [openUrl] method is used to open the given URL in the browser.
  ///
  /// This method calls the platform-specific [ShareAndOpenUrlPlatform] class's
  /// [openUrl] method.
  ///
  /// * [url]: The URL to be opened.
  Future<void> openUrl(String url) => ShareAndOpenUrlPlatform.instance.openUrl(url);
}
