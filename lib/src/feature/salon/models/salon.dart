final class Salon {
  const Salon({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
  });

  final int id;
  final String code;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String description;

  factory Salon.fromJson(Map<String, Object?> json) => Salon(
        id: json['id'] as int,
        code: json['code'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        description: json['description'] as String,
      );
}
