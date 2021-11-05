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
      name: "pill_1",
      imagePath:
          "https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/1NOwp2F6NmP",
      content: Content(desc: "약 1번이에요", components: ["모양: 동그라미", "색상: 흰색"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(children: <Widget>[discription(), pageViewWidget()]),
        ));
  }

  Widget discription() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: <Widget>[
              Expanded(flex: 9, child: Text("TOP 5")),
            ],
          ),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextSearchScreen()),
                    );
                  },
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
