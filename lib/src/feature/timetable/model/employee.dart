class Employee {
  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  int id;
  String firstName;
  String lastName;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
