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
          child: pageViewWidget(),
        ));
  }

  Widget discription() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Column(children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(
                    "입력하신 사진을 바탕으로 검색한 결과입니다. 하단의 카드를 클릭하면 웹사이트로 넘어갑니다.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CColor.largeTitle.color,
                        fontSize: 15))),
          ]),
        ));
  }

  Widget pageViewWidget() {
    return FutureBuilder<List<Pill>>(
        future: fetchPills(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PillsListScreen(Pills: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget pillResult() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_pill.imageURL),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Expanded(flex: 5, child: SizedBox()),
          Expanded(
              flex: 1,
              child: SizedBox(
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "${_pill.name}\n${_pill.manufacturer}",
                        style: CTypography.headline.style,
                      ))))),
        ],
      ),
    );
  }
}
