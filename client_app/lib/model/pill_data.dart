// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Result {
//   List<Pill> pillList;
//   List<Pill> get article => pillList;

//   Result({required this.pillList});
//   factory Result.fromJson(Map<String, dynamic> json) {
//     return Result(
//         pillList: List<Pill>.from(json['result'].map((e) => Pill.fromJson(e))));
//   }
// }

// class Pill {
//   String name;
//   String manufacturer;
//   String imageURL;
//   String webviewURL;

//   Pill(
//       {required this.name,
//       required this.manufacturer,
//       required this.imageURL,
//       required this.webviewURL});

//   factory Pill.fromJson(Map<String, dynamic> json) {
//     return Pill(
//         name: json['name'],
//         manufacturer: json['manufacturer'],
//         imageURL: json['imageURL'],
//         webviewURL: json['webviewURL']);
//   }
// }

// class ResultAPI {
//   Future<List<Pill>> fetchPhotos(http.Client client) async {
//     final response = await client
//         .get(Uri.parse('http://192.168.0.33:3306/'));
//   print(response.body);
//     // Use the compute function to run parsePhotos in a separate isolate.
//     return compute(parsePhotos, response.body);
//   }

// // A function that converts a response body into a List<Photo>.
//   List<Pill> parsePhotos(String responseBody) {
//     final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
   
//     return parsed.map<Pill>((json) => Pill.fromJson(json)).toList();
//   }

//   Future<Result> fetchPost() async {
//     final response = await http.get(Uri.parse('http://192.168.0.33:3306/'));

//     if (response.statusCode == 200) {
//       return Result.fromJson(json.decode(response.body));
//     } else {
//       // 만약 요청이 실패하면, 에러를 던집니다.
//       throw Exception('Failed to load post');
//     }
//   }
// }
