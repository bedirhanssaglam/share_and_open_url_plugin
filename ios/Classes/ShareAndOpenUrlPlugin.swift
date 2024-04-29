import Flutter
import UIKit

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
