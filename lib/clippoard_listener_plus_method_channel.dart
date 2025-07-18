import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'clippoard_listener_plus_platform_interface.dart';

/// An implementation of [ClippoardListenerPlusPlatform] that uses method channels.
class MethodChannelClippoardListenerPlus extends ClippoardListenerPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clippoard_listener_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
