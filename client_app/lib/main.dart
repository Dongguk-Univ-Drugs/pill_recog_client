import 'package:client_app/components/components.dart';
import 'package:client_app/views/bookmark/bookmark.dart';
import 'package:client_app/views/search/text/text_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './views/views.dart';
import '../../../components/components.dart';

void main() {
  runApp(const App());
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: '이미지로 검색', icon: Icons.camera_alt_rounded),
  Choice(title: '텍스트로 검색', icon: Icons.text_fields_outlined),
  Choice(title: 'QR코드로 검색', icon: Icons.qr_code_2_outlined),
  Choice(title: '북마크', icon: Icons.bookmark),
];

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('이건뭐약 💊', style: CTypography.appbarTitle.style),
            backgroundColor: CColor.primary.color,
          ),
          body: SafeArea(
            child: Padding(
                padding: padding(horizontal: 20, vertical: 25.0),
                child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.6,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () => Get.to(() => const TextSearchScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CColor.caption.color),
                            child: Column(children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Icon(choices[0].icon, size: 70.0)),
                              Expanded(flex: 1, child: Text(choices[0].title)),
                            ]),
                          )),
                      GestureDetector(
                          onTap: () => Get.to(() => const TextSearchScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CColor.caption.color),
                            child: Column(children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Icon(choices[1].icon, size: 70.0)),
                              Expanded(flex: 1, child: Text(choices[1].title)),
                            ]),
                          )),
                      GestureDetector(
                          onTap: () => Get.to(() => const TextSearchScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CColor.caption.color),
                            child: Column(children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Icon(choices[2].icon, size: 70.0)),
                              Expanded(flex: 1, child: Text(choices[2].title)),
                            ]),
                          )),
                      GestureDetector(
                          onTap: () => Get.to(() => const BookmarkScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CColor.caption.color),
                            child: Column(children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Icon(choices[3].icon, size: 70.0)),
                              Expanded(flex: 1, child: Text(choices[3].title)),
                            ]),
                          )),
                    ])),
          ),
        ));
  }

  Widget selectCard(choice) {
    return Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: CColor.primary.color, width: 3.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3, child: Icon(choice.icon, size: 70.0)),
                Expanded(flex: 1, child: Text(choice.title)),
              ]),
        ));
  }
}
