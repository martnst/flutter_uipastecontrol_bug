import 'package:flutter/cupertino.dart';
import 'package:uipastecontrol_bug/native_view_example.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: Center(
          child: NativeViewExample(),
        ),
      ),
    );
  }
}
