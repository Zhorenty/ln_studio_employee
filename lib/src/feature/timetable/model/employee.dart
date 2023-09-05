/// Employee's timetable
class Employee {
  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  /// Employee's ID
  int id;

  /// Employee's first name
  String firstName;

  /// Employee's last name
  String lastName;

  /// Returns employee from [json].
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
