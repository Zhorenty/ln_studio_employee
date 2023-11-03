import 'package:dio/dio.dart';

import '../model/booking.dart';

/// Datasource for BookingHistory data.
abstract interface class BookingHistoryDataProvider {
  /// Fetch .
  Future<List<BookingModel>> fetchEmployeeBookings(int id);
}

/// Implementation of employee datasource.
class BookingHistoryDataProviderImpl implements BookingHistoryDataProvider {
  BookingHistoryDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<List<BookingModel>> fetchEmployeeBookings(int id) async {
    final response = await restClient.get('/api/v1/employee/$id/service_sales');

    final bookings = List.from((response.data['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();

    return bookings;
  }
}
