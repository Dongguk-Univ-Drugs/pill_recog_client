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
          title: const Text("검색 결과"),
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
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(children: <Widget>[
            Expanded(flex: 1, child: Text("TOP 5", style: CTypography.headline.style,)),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(flex: 3, child: Image.network(_pill.imagePath)),
                    const Expanded(
                        flex: 2,
                        child:
                            Text("입력하신 사진을 바탕으로 검색한 결과입니다.\n\n클릭하면 웹사이트로 넘어갑니다.")),
                  ],
                ))
          ]),
        ));
  }

  Widget pageViewWidget() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: <Widget>[
          Expanded(flex: 9, child: Image.network(_pill.imagePath)),
          Expanded(
              flex: 1,
              child: Text(_pill.name,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87))),
          Expanded(
              flex: 1,
              child: Text(_pill.content.desc,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87))),
        ],
      ),
    );
  }
}
