import 'package:client_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './views/views.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('💊'),
          actions: [
            /// these button calls the recognizing screen
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Get.to(() => SearchMainScreen()),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: padding(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      highlightedText(text: '종하님,'),
                      Text(' 어서와요 😆', style: CTypography.headline.style,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
