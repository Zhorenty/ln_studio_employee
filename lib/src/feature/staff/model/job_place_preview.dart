// ignore_for_file: public_member_api_docs, sort_constructors_first

class JobPlacePreview {
  JobPlacePreview({required this.name});

  ///
  final String name;

  ///
  factory JobPlacePreview.fromJson(Map<String, dynamic> json) =>
      JobPlacePreview(name: json['name'] as String);
}
