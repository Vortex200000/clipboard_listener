📋 clipboard_listener
A Flutter plugin that listens for clipboard changes on Android and iOS.

Features
🔄 Realtime clipboard change listener
✅ Works on Android and iOS
Tested on android 10 , 13
Usage
import 'package:flutter/material.dart';
import 'package:clipboard_listener/clipboard_listener.dart';
@pragma('vm:entry-point')
void main() {
runApp(const ClipboardApp());
}

class ClipboardApp extends StatelessWidget {
const ClipboardApp({super.key});

@override
Widget build(BuildContext context) {
return const MaterialApp(
home: ClipboardHome(),
);
}
}

class ClipboardHome extends StatefulWidget {
const ClipboardHome({super.key});

@override
State<ClipboardHome> createState() => _ClipboardHomeState();
}

class _ClipboardHomeState extends State<ClipboardHome> {
String clipboardText = 'Waiting...';

@override
void initState() {
super.initState();
ClipboardListener.clipboardStream.listen((value) {
setState(() {
clipboardText = value;
});
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Clipboard Listener")),
body: Center(child: Text("Clipboard: $clipboardText")),
);
}
}