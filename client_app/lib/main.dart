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
          title: const Text('Pill Recog'),
          actions: [
            /// these button calls the recognizing screen
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Get.to(() => SearchMainScreen()),
            ),
          ],
        ),
        body: const Center(
          child: Text('Hello world'),
        ),
      ),
    );
  }
}
