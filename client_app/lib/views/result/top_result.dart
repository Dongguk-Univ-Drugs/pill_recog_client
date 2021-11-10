import 'package:client_app/model/pill_data.dart';
import 'package:client_app/views/result/get_result.dart';
import 'package:client_app/views/result/web_view.dart';
import 'package:client_app/views/search/text/text_search.dart';
import 'package:client_app/views/search/text/text_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './top_result_controller.dart';
import '../../../components/components.dart';
import 'package:http/http.dart' as http;

class TopResultScreen extends StatefulWidget {
  const TopResultScreen({Key? key}) : super(key: key);

  @override
  _TopResultScreenState createState() => _TopResultScreenState();
}

class _TopResultScreenState extends State<TopResultScreen> {
  int _index = 0;
  final Pill _pill = Pill(
    name: "액시드캡슐150밀리그람",
    manufacturer: "삼진제약",
    imageURL: "https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/1NOwp2F6NmP",
    webviewURL:
        "https://nedrug.mfds.go.kr/pbp/CCBBB01/getItemDetail?itemSeq=200300408",
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("검색 결과", style: CTypography.appbarTitle.style),
          backgroundColor: CColor.primary.color,
        ),
        body: Center(
          child: Column(children: <Widget>[Expanded(child: pageViewWidget())]),
        ));
  }

  Widget pageViewWidget() {
    return FutureBuilder<Result>(
        future: fetchPill(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.result.isEmpty) {
              return emptyResult();
            }
            return PillsListScreen(Pills: snapshot.data!.result);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget emptyResult() {
    return Center(
        child: Text("검색된 알약이 없습니다.",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CColor.largeTitle.color,
                fontSize: 20)));
  }
}
