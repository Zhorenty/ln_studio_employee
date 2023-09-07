// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JobPlacePreview {
  JobPlacePreview({required this.name});

  ///
  final String name;

  ///
  Map<String, dynamic> toMap() => <String, dynamic>{'name': name};

  ///
  factory JobPlacePreview.fromMap(Map<String, dynamic> map) =>
      JobPlacePreview(name: map['name'] as String);

  ///
  String toJson() => json.encode(toMap());

  ///
  factory JobPlacePreview.fromJson(String source) =>
      JobPlacePreview.fromMap(json.decode(source) as Map<String, dynamic>);
}
