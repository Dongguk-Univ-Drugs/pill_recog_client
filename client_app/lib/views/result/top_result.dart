import 'package:client_app/model/pill_data.dart';
import 'package:client_app/views/result/web_view.dart';
import 'package:client_app/views/search/text/text_search.dart';
import 'package:client_app/views/search/text/text_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './top_result_controller.dart';
import '../../../components/components.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class TopResultScreen extends StatefulWidget {
  const TopResultScreen({Key? key}) : super(key: key);

  @override
  _TopResultScreenState createState() => _TopResultScreenState();
}

class _TopResultScreenState extends State<TopResultScreen> {
  int _index = 0;
  final Pill _pill = Pill(
      id: "1",
      name: "액시드캡슐150밀리그람",
      imagePath:
          "https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/1NOwp2F6NmP",
      url:
          "https://nedrug.mfds.go.kr/pbp/CCBBB01/getItemDetail?itemSeq=200300408",
      content: Content(desc: "약 1번이에요", components: ["모양: 동그라미", "색상: 흰색"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("검색 결과", style: CTypography.appbarTitle.style),
          backgroundColor: CColor.primary.color,
        ),
        body: Center(
          child: Column(children: <Widget>[discription(), pageViewWidget()]),
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
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: PageView.builder(
          itemCount: 5,
          controller: PageController(viewportFraction: 0.8),
          onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (_, i) {
            return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: GestureDetector(
                  onTap: () => Get.to(() => WebViewScreen(
                        name: _pill.name,
                        url: _pill.url,
                      )),
                  child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: pillResult()),
                ));
          },
        ),
      ),
    );
  }

  Widget pillResult() {
    void _selectItem({value}) {
      print(value ?? "null");
    }

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_pill.imagePath),
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
                        "${_pill.name}\n${_pill.content.desc}",
                        style: CTypography.headline.style,
                      ))))),
        ],
      ),
    );
  }
}
