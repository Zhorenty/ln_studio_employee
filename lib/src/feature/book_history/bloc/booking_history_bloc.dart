import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/book_history/data/booking_history_repository.dart';

import '/src/common/utils/error_util.dart';
import 'booking_history_event.dart';
import 'booking_history_state.dart';

/// BookingHistory bloc.
class BookingHistoryBloc
    extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc({required this.repository})
      : super(const BookingHistoryState.idle()) {
    on<BookingHistoryEvent>(
      (event, emit) => event.map(
        fetch: (event) => fetchByEmployee(event, emit),
      ),
    );
  }

  /// Repository for BookingHistory data.
  final BookingHistoryRepository repository;

  /// Fetch BookingHistory from repository.
  Future<void> fetchByEmployee(
    BookingHistoryEvent$Fetch event,
    Emitter<BookingHistoryState> emit,
  ) async {
    try {
      final bookingHistory = await repository.getEmployeeBookings(event.id);
      emit(BookingHistoryState.loaded(bookingHistory: bookingHistory));
    } on Object catch (e) {
      emit(
        BookingHistoryState.idle(
          bookingHistory: state.bookingHistory,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
