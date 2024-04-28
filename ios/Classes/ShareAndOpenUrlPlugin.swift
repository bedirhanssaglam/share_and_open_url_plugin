import Flutter
import UIKit

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
