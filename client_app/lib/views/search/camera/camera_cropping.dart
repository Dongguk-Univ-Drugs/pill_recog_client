import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../components/components.dart';
import '../../result/get_result.dart';
import '../../../model/pill_data.dart';
import 'camera_result.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CroppingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('이미지로 검색', style: CTypography.appbarTitle.style),
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
  int loadingState = 0;

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
        body: Container(
      child: imageFile != null
          ? Stack(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.file(
                          imageFile!,
                          fit: BoxFit.contain,
                          // width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.55,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\n알약 촬영 시 주의 사항',
                            style: CTypography.headline.style),
                        Text('1. 배경이 균일한 곳에서 촬영해주세요.',
                            style: CTypography.body.style),
                        Text('2. 알약을 위 이미지와 같이 중앙에 위치시켜주세요.',
                            style: CTypography.body.style),
                        Text('3. 자르기를 통해 알약만 남겨주세요.',
                            style: CTypography.body.style),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            primary: Colors.deepOrange, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          child: state == AppState.free
                              ? Text('이미지 촬영/선택',
                                  style: CTypography.appbarTitle.style)
                              : state == AppState.picked
                                  ? Text('이미지 자르기',
                                      style: CTypography.appbarTitle.style)
                                  : Text('식별하기',
                                      style: CTypography.appbarTitle.style),
                          onPressed: () {
                            if (state == AppState.free)
                              _showActionSheet();
                            else if (state == AppState.picked)
                              _cropImage();
                            else if (state == AppState.cropped)
                              _transportImage();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              state == AppState.cropped && loadingState == 1
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.deepOrange,
                          strokeWidth: 10,
                        ),
                        Text('\n식별 중',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.w700))
                      ],
                    ))
                  : SizedBox()
            ])
          : Container(
              width: MediaQuery.of(context).size.width * 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/exampleImage.png'),
                        fit: BoxFit.contain,

                        // width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.55,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\n알약 촬영 시 주의 사항',
                          style: CTypography.headline.style),
                      Text('1. 배경이 균일한 곳에서 촬영해주세요.',
                          style: CTypography.body.style),
                      Text('2. 알약을 위 이미지와 같이 중앙에 위치시켜주세요.',
                          style: CTypography.body.style),
                      Text('3. 자르기를 통해 알약만 남겨주세요.',
                          style: CTypography.body.style),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          primary: Colors.deepOrange, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: state == AppState.free
                            ? Text('이미지 촬영/선택',
                                style: CTypography.appbarTitle.style)
                            : state == AppState.picked
                                ? Text('이미지 자르기',
                                    style: CTypography.appbarTitle.style)
                                : Text('식별하기',
                                    style: CTypography.appbarTitle.style),
                        onPressed: () {
                          if (state == AppState.free)
                            _showActionSheet();
                          else if (state == AppState.picked)
                            _cropImage();
                          else if (state == AppState.cropped) _transportImage();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    )
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.deepOrange,
        //   onPressed: () {
        //     if (state == AppState.free)
        //       _showActionSheet();
        //     else if (state == AppState.picked)
        //       _cropImage();
        //     else if (state == AppState.cropped) _transportImage();
        //     // if (state == AppState.free)
        //     //   _pickImage();
        //     // else if (state == AppState.picked)
        //     //   _cropImage();
        //     // else if (state == AppState.cropped) _clearImage();
        //   },
        // child: _buildButtonIcon(),
        // ),
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
    setState(() {
      loadingState = 1;
    });
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        "http://192.168.0.9:8000/file/",
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
      final String jsonBody = await onValue.stream.bytesToString();

      print('status : ' + onValue.statusCode.toString());
      print(jsonBody);
      print(onValue.headers.toString());

      // Response 결과처리
      if (onValue.statusCode == 200) {
        print('Success pill Test');
        List<Pill> resultPills = Result.fromJson(json.decode(jsonBody)).result;
        Get.to(CameraResultScreen(resultPills: resultPills));
        // Navigator.pop(context);
      } else {
        print('Fail pill Test');
        print(onValue.statusCode.toString());
        setState(() {
          loadingState = 0;
        });
      }
    });
  }
}
