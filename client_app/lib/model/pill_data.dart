import 'dart:convert';

class Pill {
  String id;
  String name;
  String imagePath;
  String url;
  Content content;

  Pill(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.url,
      required this.content});

  factory Pill.fromJson(Map<String, dynamic> json) {
    return Pill(
        id: json['_id'],
        name: json['name'],
        imagePath: json['imagePath'],
        url: json['url'],
        content: Content.fromJson(json['content']));
  }
}

class Content {
  final String desc;
  final List<String> components;

  Content({required this.desc, required this.components});

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(desc: json['desc'], components: List.from(json['components']));
}
