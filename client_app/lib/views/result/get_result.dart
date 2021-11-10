import 'dart:async';
import 'dart:convert';

import 'package:client_app/components/colors.dart';
import 'package:client_app/components/typography.dart';
import 'package:client_app/views/result/web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<List<Pill>> fetchPills(http.Client client) async {
  final response = await client.get(Uri.parse('http://192.168.0.33:3306/'));

  // Use the compute function to run parsePills in a separate isolate.
  return compute(parsePills, response.body);
}

// A function that converts a response body into a List<Pill>.
List<Pill> parsePills(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Pill>((json) => Pill.fromJson(json)).toList();
}

class Pill {
  String name;
  String manufacturer;
  String imageURL;
  String webviewURL;

  Pill(
      {required this.name,
      required this.manufacturer,
      required this.imageURL,
      required this.webviewURL});

  factory Pill.fromJson(Map<String, dynamic> json) {
    return Pill(
      name: json['name'] as String,
      manufacturer: json['manufacturer'] as String,
      imageURL: json['imageURL'] as String,
      webviewURL: json['webviewURL'] as String,
    );
  }
}

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
                            url: widget.Pills[i].imageURL,
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
