import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:share_and_open_url/share_and_open_url_method_channel.dart';

abstract class ShareAndOpenUrlPlatform extends PlatformInterface {
  /// Constructs a ShareAndOpenUrlPlatform.
  ShareAndOpenUrlPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShareAndOpenUrlPlatform _instance = MethodChannelShareAndOpenUrl();

  /// The default instance of [ShareAndOpenUrlPlatform] to use.
  ///
  /// Defaults to [MethodChannelShareAndOpenUrl].
  static ShareAndOpenUrlPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShareAndOpenUrlPlatform] when
  /// they register themselves.
  static set instance(ShareAndOpenUrlPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> shareText(String text);

  Future<void> openUrl(String url);
}
