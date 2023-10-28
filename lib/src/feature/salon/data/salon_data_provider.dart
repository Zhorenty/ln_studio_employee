import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/salon/models/salon.dart';

/// Abstract interface class for providing salon data.
abstract class SalonDataProvider {
  /// Fetches a list of salons.
  ///
  /// Returns a Future that completes with a List of Salon objects.
  Future<List<Salon>> fetchSalons();

  /// Saves the current salon ID.
  ///
  /// Takes an integer [id] as input and returns a Future that completes with void.
  FutureOr<void> saveCurrentSalonId(int id);

  /// Gets the current salon ID.
  ///
  /// Returns a FutureOr that completes with an integer or null if the salon ID is not set.
  FutureOr<int?> getCurrentSalonId();
}

/// Implementation class for providing salon data.
class SalonDataProviderImpl implements SalonDataProvider {
  /// Constructs a SalonDataProviderImpl instance.
  ///
  /// Requires a Dio and SharedPreferences instance.
  const SalonDataProviderImpl({
    required Dio restClient,
    required SharedPreferences prefs,
  })  : _restClient = restClient,
        _prefs = prefs;

  final Dio _restClient;
  final SharedPreferences _prefs;
  final currentSalonIdDBKey = 'currentSalon';

  @override
  Future<List<Salon>> fetchSalons() async {
    final response = await _restClient.get('/api/v1/salon');
    final salons =
        List.from(response.data['data']).map((e) => Salon.fromJson(e)).toList();
    return salons;
  }

  @override
  FutureOr<int?> getCurrentSalonId() => _prefs.getInt(currentSalonIdDBKey);

  @override
  FutureOr<void> saveCurrentSalonId(int id) =>
      _prefs.setInt(currentSalonIdDBKey, id);
}
