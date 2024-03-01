import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/reviews/employee_reviews_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/reviews/employee_reviews_state.dart';
import 'package:ln_employee/src/feature/employee/data/employee_repository.dart';

/// Business Logic Component EmployeeReviewsBLoC
class EmployeeReviewsBLoC
    extends Bloc<EmployeeReviewsEvent, EmployeeReviewsState> {
  EmployeeReviewsBLoC({
    required final EmployeeRepository repository,
    final EmployeeReviewsState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const EmployeeReviewsState.idle(
                reviews: [],
                message: 'Initial idle state',
              ),
        ) {
    on<EmployeeReviewsEvent>(
      (event, emit) => switch (event) {
        EmployeeReviewsEvent$FetchReviews() => _fetchReviews(event, emit),
      },
    );
  }

  ///
  final EmployeeRepository _repository;

  /// Fetch event handler
  Future<void> _fetchReviews(
    EmployeeReviewsEvent$FetchReviews event,
    Emitter<EmployeeReviewsState> emit,
  ) async {
    emit(EmployeeReviewsState.processing(reviews: state.reviews));
    try {
      final reviews = await _repository.fetchReviews(event.employeeId);
      emit(EmployeeReviewsState.successful(reviews: reviews));
    } on Object catch (err, _) {
      emit(EmployeeReviewsState.error(reviews: state.reviews));
      rethrow;
    } finally {
      emit(EmployeeReviewsState.idle(reviews: state.reviews));
    }
  }
}
