import 'dart:io';

/// Business Logic Component create_employee_event Events
sealed class CreateEmployeeEvent {
  const CreateEmployeeEvent();

  /// Create
  const factory CreateEmployeeEvent.create({
    // Да это жесть везде это прописывать, надот ещё посмотреть про модели для таких запросов
    File? avatar,
    required String firstName,
    required String lastName,
    required String phone,
    String? address,
    required String description,
    required int specializationId,
    required int salonId,
    required int stars,
    required int percentageOfSales,
  }) = CreateEmployeeEvent$Create;
}

/// {@template create_employee_event}
/// CreateEmployeeEvent class
/// {@endtemplate}
class CreateEmployeeEvent$Create extends CreateEmployeeEvent {
  /// {@macro create_employee_event}
  const CreateEmployeeEvent$Create({
    this.avatar,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.address,
    required this.description,
    required this.specializationId,
    required this.salonId,
    required this.stars,
    required this.percentageOfSales,
  });

  final File? avatar;
  final String firstName;
  final String lastName;
  final String phone;
  final String? address;
  final String description;
  final int specializationId;
  final int salonId;
  final int stars;
  final int percentageOfSales;
}
