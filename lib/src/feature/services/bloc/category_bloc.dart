import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/services/data/services_repository.dart';

import '/src/common/utils/error_util.dart';
import 'category_event.dart';
import 'category_state.dart';

/// Record bloc.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.repository}) : super(const CategoryState.idle()) {
    on<CategoryEvent>(
      (event, emit) => event.map(
        fetchServiceCategories: (event) => _fetchServiceCategories(event, emit),
      ),
    );
  }

  /// Repository for Services data.
  final ServicesRepository repository;

  /// Fetch record from repository.
  Future<void> _fetchServiceCategories(
    CategoryEvent$FetchServiceCategories event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final categories = await repository.getServiceCategories();
      emit(CategoryState.loaded(categoryWithServices: categories));
    } on Object catch (e) {
      emit(
        CategoryState.idle(
          categoryWithServices: state.categoryWithServices,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
