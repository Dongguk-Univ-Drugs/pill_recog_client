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
import 'dart:convert';
import 'package:http/http.dart' as http;

class CameraResultScreen extends StatelessWidget {
  final List<Pill> resultPills;

  CameraResultScreen({required this.resultPills});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('식별 결과', style: CTypography.appbarTitle.style),
          backgroundColor: CColor.primary.color,
        ),
        body: SafeArea(
            child: Padding(
                padding: padding(horizontal: 20, vertical: 25.0),
                child: resultPills.isEmpty == false
                    ? PillsListScreen(Pills: resultPills)
                    : Center(
                        child: Text("검색된 알약이 없습니다.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: CColor.largeTitle.color,
                                fontSize: 20))))));
  }
}
