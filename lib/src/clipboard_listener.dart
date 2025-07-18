import 'package:flutter/services.dart';

import '../clippoard_listener_plus_platform_interface.dart';

class ClipboardListener {
  static const EventChannel _eventChannel =
  EventChannel('clipboard_listener/events');

  static Stream<String> get clipboardStream {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as String);
  }

Future<String?> getPlatformVersion() {
  return ClippoardListenerPlusPlatform.instance.getPlatformVersion();
}
}
