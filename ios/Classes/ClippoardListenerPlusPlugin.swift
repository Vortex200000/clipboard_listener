import Flutter
import UIKit

public class ClippoardListenerPlusPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?
  private var lastClipboard: String?
  private var timer: Timer?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let eventChannel = FlutterEventChannel(name: "clipboard_listener/events", binaryMessenger: registrar.messenger())
    let instance = ClipboardListenerPlugin()
    eventChannel.setStreamHandler(instance)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    self.lastClipboard = UIPasteboard.general.string

    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }

      let current = UIPasteboard.general.string
      if current != self.lastClipboard {
        self.lastClipboard = current
        if let current = current {
          self.eventSink?(current)
        }
      }
    }

    RunLoop.main.add(timer!, forMode: .common) // Ensure it works even during UI interactions

    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    timer?.invalidate()
    timer = nil
    eventSink = nil
    return nil
  }
}
