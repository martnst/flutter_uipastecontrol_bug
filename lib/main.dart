import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uipastecontrol_bug/native_view_example.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        // ⬇ 🔥 🔥 🔥 setting this property caused the app to prompt for user consent
        barBackgroundColor: Colors.yellow,
        // barBackgroundColor: null,
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: Center(
          child: NativeViewExample(),
        ),
      ),
    );
  }
}
