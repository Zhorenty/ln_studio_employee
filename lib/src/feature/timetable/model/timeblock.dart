class Timetable {
  final int id;
  final DateTime dateAt;
  final dynamic salary;
  final bool onWork;

  Timetable({
    required this.id,
    required this.dateAt,
    required this.salary,
    required this.onWork,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      id: json['id'] as int,
      dateAt: DateTime.parse(json['date_at'] as String),
      salary: json['salary'],
      onWork: json['on_work'] as bool,
    );
  }
}
