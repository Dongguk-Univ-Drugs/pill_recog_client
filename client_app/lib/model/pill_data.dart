import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Result {
  List<Pill> result;
  String time;

  Result({required this.result, required this.time});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        result: List<Pill>.from(json['result'].map((e) => Pill.fromJson(e))),
        time: json['time']);
  }
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

Future<Result> fetchPill(http.Client client) async {
  final response = await client.get(Uri.parse('http://192.168.0.33:3306/'));

  if (response.statusCode == 200) {
    return Result.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
