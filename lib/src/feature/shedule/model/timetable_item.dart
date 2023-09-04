import 'package:flutter/foundation.dart';

/// Элемент расписания
@immutable
final class TimetableItem {
  const TimetableItem({
    required this.id,
    required this.dateAt,
    this.salary,
    this.onWork = false,
  });

  final int id;

  /// Дата когда сотрудник должен выйти
  final DateTime dateAt;

  final int? salary;

  final bool onWork;

  factory TimetableItem.fromJson(Map<String, Object?> json) => TimetableItem(
        id: json['id'] as int,
        dateAt: DateTime.parse(json['date_at'] as String),
        salary: json['salary'] as int?,
        onWork: json['on_work'] as bool,
      );

  Map<String, Object?> toJson() => {};

  @override
  String toString() => 'Employee(dateAt: $dateAt)';
}
