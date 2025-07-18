import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'clippoard_listener_plus_method_channel.dart';

abstract class ClippoardListenerPlusPlatform extends PlatformInterface {
  /// Constructs a ClippoardListenerPlusPlatform.
  ClippoardListenerPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static ClippoardListenerPlusPlatform _instance = MethodChannelClippoardListenerPlus();

  /// The default instance of [ClippoardListenerPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelClippoardListenerPlus].
  static ClippoardListenerPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ClippoardListenerPlusPlatform] when
  /// they register themselves.
  static set instance(ClippoardListenerPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
