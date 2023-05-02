import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeViewExample extends StatefulWidget {
  const NativeViewExample({super.key});

  @override
  State<NativeViewExample> createState() => _NativeViewExampleState();
}

class _NativeViewExampleState extends State<NativeViewExample> {
  static const platform = MethodChannel('samples.flutter.dev/clipboard');
  String? clipboardText;

  @override
  void initState() {
    super.initState();

    platform.setMethodCallHandler((call) async {
      setState(() {
        clipboardText = call.arguments;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 220,
          width: 330,
          child: UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.green.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(clipboardText ?? "clipboard text will go here"),
          ),
        ),
      ],
    );
  }
}
