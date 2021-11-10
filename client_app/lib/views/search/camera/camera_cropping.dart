import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../components/components.dart';
import 'package:http/http.dart' as http;

class CroppingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('이건뭐약 💊', style: CTypography.appbarTitle.style),
          backgroundColor: CColor.primary.color,
        ),
        body: SafeArea(
            child: Padding(
          padding: padding(horizontal: 20, vertical: 25.0),
          child: CroppingImageScreen(),
        )));
  }
}

class CroppingImageScreen extends StatefulWidget {
  @override
  _CroppingImageScreenState createState() => _CroppingImageScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CroppingImageScreenState extends State<CroppingImageScreen> {
  late AppState state;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(widget.title),
      // ),
      body: Center(
        child: imageFile != null ? Image.file(imageFile!) : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          if (state == AppState.free)
            _showActionSheet();
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _transportImage();
          // if (state == AppState.free)
          //   _pickImage();
          // else if (state == AppState.picked)
          //   _cropImage();
          // else if (state == AppState.cropped) _clearImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  void _showActionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min, // 设置最小的弹出
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text("카메라"),
                  onTap: () {
                    _captureImage();
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text("사진첩"),
                  onTap: () {
                    _pickImage();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _captureImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: '',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _transportImage() async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        "http://192.168.0.32:8000/file/",
      ),
    );

    // 이미지 파일 -> byte stream
    var bytes = imageFile!.readAsBytesSync();
    // 멀티파트 파일로 변환
    var mpFile =
        http.MultipartFile.fromBytes('file', bytes, filename: 'pillImage');
    //Files 영역  // 필드명 'file'
    print(bytes.length);
    request.files.add(mpFile);
    //Header 영역
    request.headers["Content-Type"] = 'multipart/form-data';
    print('Start Sending');
    //request 전송
    request.send().then((onValue) async {
      final jsonBody = await onValue.stream.bytesToString();

      print('status : ' + onValue.statusCode.toString());
      print('result : ' + jsonBody);
      print(onValue.headers.toString());

      // Response 결과처리
      if (onValue.statusCode == 200) {
        print('Success pill Test');
        // Navigator.pop(context);
      } else {
        print('Fail pill Test');
        print(onValue.statusCode.toString());
      }
    });
  }
}
