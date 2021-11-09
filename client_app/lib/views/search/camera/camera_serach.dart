import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/components.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'camera_screen.dart';

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraSearchScreen extends StatefulWidget {
  const CameraSearchScreen({Key? key}) : super(key: key);

  @override
  _CameraSearchScreenState createState() => _CameraSearchScreenState();
}

class _CameraSearchScreenState extends State<CameraSearchScreen> {
  final GlobalKey _formKey = GlobalKey();
  List<CameraDescription> cameras = [];

  /// controller
  late final ScrollController scrollController;

  /// variables selected by user

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: CColor.primary.color,
              title: const Text('Camera Search'),
            ),
            SliverPadding(
              padding: padding(horizontal: 8.0, vertical: 16.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate(
                <Widget>[
                  TextFormField(
                    decoration: roundedInputDecoration(
                      labelText: '약품명',
                      icon: const Icon(Icons.text_format_rounded),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await initCamera();
                      // Get.to(MyApp());
                      Get.to(CameraScreen(cameras: cameras));
                    },
                    child: const Text('촬영하기'),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
