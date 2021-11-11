import 'package:client_app/components/colors.dart';
import 'package:client_app/components/typography.dart';
import 'package:client_app/model/pill_data.dart';
import 'package:client_app/views/result/web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PillsListScreen extends StatefulWidget {
  const PillsListScreen({Key? key, required this.Pills}) : super(key: key);
  final List<Pill> Pills;
  @override
  _PillsListScreenState createState() => _PillsListScreenState();
}

class _PillsListScreenState extends State<PillsListScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        discription(),
        Expanded(
            flex: 10,
            child: PageView.builder(
              itemCount: widget.Pills.length,
              controller: PageController(viewportFraction: 0.8),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (_, i) {
                return Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: GestureDetector(
                      onTap: () => Get.to(() => WebViewScreen(
                            name: widget.Pills[i].name,
                            url: widget.Pills[i].webviewURL,
                          )),
                      child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: pillResult(widget.Pills[i])),
                    ));
              },
            )),
        Expanded(
          flex: 1,
          child: SizedBox(),
        )
      ],
    );
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

  Widget pillResult(_pill) {
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
