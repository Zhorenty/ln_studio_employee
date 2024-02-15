import 'package:dio/dio.dart';

import '../model/booking.dart';

/// Datasource for BookingHistory data.
abstract interface class BookingHistoryDataProvider {
  /// Fetch .
  Future<List<BookingModel>> fetchEmployeeBookings(int id);

  /// Make booking done .
  Future<void> makeEmployeeBookingDone(int id);

  Future<void> cancelRecord(int recordId);
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

  @override
  Future<void> makeEmployeeBookingDone(int id) =>
      restClient.patch('/api/v1/service_sale/$id/make_done');

  @override
  Future<void> cancelRecord(int recordId) =>
      restClient.get('/api/v1/book/cancel/$recordId');
}
