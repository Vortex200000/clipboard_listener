import 'package:flutter_test/flutter_test.dart';
import 'package:clippoard_listener_plus/clippoard_listener_plus.dart';
import 'package:clippoard_listener_plus/clippoard_listener_plus_platform_interface.dart';
import 'package:clippoard_listener_plus/clippoard_listener_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockClippoardListenerPlusPlatform
    with MockPlatformInterfaceMixin
    implements ClippoardListenerPlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ClippoardListenerPlusPlatform initialPlatform = ClippoardListenerPlusPlatform.instance;

  test('$MethodChannelClippoardListenerPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelClippoardListenerPlus>());
  });

  test('getPlatformVersion', () async {
    ClipboardListener clippoardListenerPlusPlugin = ClipboardListener();
    MockClippoardListenerPlusPlatform fakePlatform = MockClippoardListenerPlusPlatform();
    ClippoardListenerPlusPlatform.instance = fakePlatform;

    expect(await clippoardListenerPlusPlugin.getPlatformVersion(), '42');
  });
}
