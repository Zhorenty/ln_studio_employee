// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserPreview {
  UserPreview({
    required this.photo,
    required this.firstName,
    required this.lastName,
  });
  final String? photo;

  final String firstName;

  final String lastName;

  factory UserPreview.fromJson(Map<String, dynamic> json) {
    return UserPreview(
      photo: json['photo'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
