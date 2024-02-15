import '../model/booking.dart';
import 'booking_history_data_provider.dart';

/// Repository for employee data.
abstract interface class BookingHistoryRepository {
  /// Get employee by id.
  Future<List<BookingModel>> getEmployeeBookings(int id);

  /// Make booking done .
  Future<void> makeEmployeeBookingDone(int id);

  Future<void> cancelRecord(int recordId);
}

/// Implementation of the employee repository.
final class BookingHistoryRepositoryImpl implements BookingHistoryRepository {
  BookingHistoryRepositoryImpl(this._dataSource);

  /// Employee data provider.
  final BookingHistoryDataProvider _dataSource;

  @override
  Future<List<BookingModel>> getEmployeeBookings(int id) =>
      _dataSource.fetchEmployeeBookings(id);

  @override
  Future<void> makeEmployeeBookingDone(int id) =>
      _dataSource.makeEmployeeBookingDone(id);

  @override
  Future<void> cancelRecord(int recordId) => _dataSource.cancelRecord(recordId);
}
