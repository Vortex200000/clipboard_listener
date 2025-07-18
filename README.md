# 📋 clipboard_listener_plus

[![pub package](https://img.shields.io/pub/v/clippoard_listener_plus.svg)](https://pub.dev/packages/clippoard_listener_plus)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-android%20%7C%20ios-lightgrey.svg)](https://pub.dev/packages/clippoard_listener_plus)

A powerful Flutter plugin that provides real-time clipboard change detection for Android and iOS applications. Monitor clipboard content changes seamlessly with a simple, efficient stream-based API.

## ✨ Features

- 🔄 **Real-time monitoring** - Instantly detect clipboard changes
- 📱 **Cross-platform** - Works on both Android and iOS
- 🎯 **Stream-based API** - Easy integration with Flutter's reactive programming
- ⚡ **Lightweight** - Minimal performance impact with efficient polling
- 🛡️ **Reliable** - Thoroughly tested on multiple device versions
- 🔧 **Easy to use** - Simple one-line integration

## 🚀 Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  clippoard_listener_plus: ^0.0.4
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:clippoard_listener_plus/clippoard_listener_plus.dart';
```

## 📖 Usage

### Basic Implementation

```dart
import 'package:flutter/material.dart';
import 'package:clippoard_listener_plus/clippoard_listener_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Clipboard Listener Demo',
      home: ClipboardPage(),
    );
  }
}

class ClipboardPage extends StatefulWidget {
  const ClipboardPage({super.key});
  
  @override
  State<ClipboardPage> createState() => _ClipboardPageState();
}

class _ClipboardPageState extends State<ClipboardPage> {
  String clipboardText = 'Waiting for clipboard changes...';
  late StreamSubscription<String> _clipboardSubscription;

  @override
  void initState() {
    super.initState();
    // Start listening to clipboard changes
    _clipboardSubscription = ClipboardListener.clipboardStream.listen(
      (String newClipboardText) {
        setState(() {
          clipboardText = newClipboardText;
        });
        print('Clipboard changed: $newClipboardText');
      },
      onError: (error) {
        print('Clipboard listener error: $error');
      },
    );
  }

  @override
  void dispose() {
    // Important: Cancel the subscription to prevent memory leaks
    _clipboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clipboard Listener'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.content_paste,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Latest Clipboard Content:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                clipboardText,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Advanced Usage with StreamBuilder

```dart
class ClipboardStreamWidget extends StatelessWidget {
  const ClipboardStreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: ClipboardListener.clipboardStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        
        if (snapshot.hasData) {
          return Text('Clipboard: ${snapshot.data}');
        }
        
        return const Text('Waiting for clipboard changes...');
      },
    );
  }
}
```

## 🔧 API Reference

### ClipboardListener

#### Static Properties

| Property | Type | Description |
|----------|------|-------------|
| `clipboardStream` | `Stream<String>` | A broadcast stream that emits clipboard content changes |

#### Methods

The plugin automatically starts monitoring when you listen to the stream and stops when all listeners are removed.

## 🛠️ Platform Support

| Platform | Status | Minimum Version |
|----------|--------|-----------------|
| Android | ✅ | API 16 (Android 4.1) |
| iOS | ✅ | iOS 9.0 |

### Tested Devices

- ✅ Android 10
- ✅ Android 13
- ✅ iOS 14+
- ✅ iOS 16+

## ⚠️ Important Notes

### Memory Management
Always cancel your stream subscription to prevent memory leaks:

```dart
late StreamSubscription<String> _subscription;

@override
void initState() {
  super.initState();
  _subscription = ClipboardListener.clipboardStream.listen((text) {
    // Handle clipboard change
  });
}

@override
void dispose() {
  _subscription.cancel(); // Important!
  super.dispose();
}
```

### Performance Considerations
- The plugin polls clipboard changes every 1 second
- Only text content is monitored (images and other formats are ignored)
- The stream only emits when clipboard content actually changes

### Privacy & Permissions
- **Android**: No special permissions required
- **iOS**: No special permissions required
- The plugin only reads clipboard content, never writes to it

## 🐛 Troubleshooting

### Common Issues

**Plugin not working after adding dependency:**
```bash
flutter clean
flutter pub get
flutter run
```

**MissingPluginException:**
- Ensure you've restarted your app completely (not just hot reload)
- Check that you're using the latest version of the plugin

**Stream not receiving updates:**
- Verify you haven't cancelled the subscription accidentally
- Check that your app has proper lifecycle management

## 📝 Example Project

A complete example project is available in the [example](./example) directory. To run it:

```bash
cd example
flutter pub get
flutter run
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Thanks to the Flutter team for the excellent plugin architecture
- Inspired by the need for real-time clipboard monitoring in Flutter applications

## 📞 Support

- 🐛 [Report bugs](https://github.com/Vortex200000/clipboard_listener/issues)
- 💡 [Request features](https://github.com/Vortex200000/clipboard_listener/issues)
- 📧 [Contact maintainer](mailto:omaressam746@gmail.com)

---

Made with ❤️ for the Flutter community