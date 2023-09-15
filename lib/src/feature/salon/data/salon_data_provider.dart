import 'dart:async';

import '/src/feature/salon/models/salon.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
abstract interface class SalonDataProvider {
  ///
  Future<List<Salon>> fetchSalons();

  ///
  FutureOr<void> saveCurrentSalonId(int id);

  ///
  FutureOr<int?> getCurrentSalonId();
}

///
final class SalonDataProviderImpl implements SalonDataProvider {
  const SalonDataProviderImpl({
    required RestClient restClient,
    required SharedPreferences prefs,
  })  : _restClient = restClient,
        _prefs = prefs;

  ///
  final RestClient _restClient;

  ///
  final SharedPreferences _prefs;

  ///
  final currentSalonIdDBKey = 'currentSalon';

  @override
  Future<List<Salon>> fetchSalons() async {
    final response = await _restClient.get('/api/salon/all');
    final salons = List.from(response['data'] as List)
        .map((e) => Salon.fromJson(e))
        .toList();

    return salons;
  }

  @override
  FutureOr<int?> getCurrentSalonId() => _prefs.getInt(currentSalonIdDBKey);

  @override
  FutureOr<void> saveCurrentSalonId(int id) =>
      _prefs.setInt(currentSalonIdDBKey, id);
}
