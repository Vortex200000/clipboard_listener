# 📋 clipboard_listener

A Flutter plugin that listens for clipboard changes on Android and iOS.

## Features

- 🔄 Realtime clipboard change listener
- ✅ Works on Android and iOS
- tested on android 10 , 13
## Usage

```dart
import 'package:flutter/material.dart';
import 'package:clipboard_listener/clipboard_listener.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ClipboardPage());
  }
}

class ClipboardPage extends StatefulWidget {
  const ClipboardPage({super.key});
  @override
  State<ClipboardPage> createState() => _ClipboardPageState();
}

class _ClipboardPageState extends State<ClipboardPage> {
  String text = 'Waiting...';

  @override
  void initState() {
    super.initState();
    ClipboardListener.clipboardStream.listen((value) {
      setState(() => text = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clipboard Listener')),
      body: Center(child: Text(text)),
    );
  }
}
