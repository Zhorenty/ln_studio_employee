import 'dart:async';

import 'package:ln_employee/src/feature/salon/models/salon.dart';

import 'salon_data_provider.dart';

abstract interface class SalonRepository {
  Future<List<Salon>> fetchSalons();
  FutureOr<void> saveCurrentSalonId(int id);
  FutureOr<int?> getCurrentSalonId();
}

class SalonRepositoryImpl implements SalonRepository {
  const SalonRepositoryImpl(SalonDataProvider dataProvider)
      : _dataProvider = dataProvider;

  final SalonDataProvider _dataProvider;

  @override
  Future<List<Salon>> fetchSalons() => _dataProvider.fetchSalons();

  @override
  FutureOr<int?> getCurrentSalonId() => _dataProvider.getCurrentSalonId();

  @override
  FutureOr<void> saveCurrentSalonId(int id) =>
      _dataProvider.saveCurrentSalonId(id);
}
