import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/specialization/bloc/specialization_event.dart';
import '/src/feature/specialization/bloc/specialization_state.dart';
import '/src/feature/specialization/data/specialization_repository.dart';

/// Specialization bloc.
class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  SpecializationBloc({required this.repository})
      : super(const SpecializationState.idle()) {
    on<SpecializationEvent>(
      (event, emit) => event.map(
        fetchAll: (event) => _fetchAll(event, emit),
      ),
    );
  }

  /// Repository for staff data.
  final SpecializationRepository repository;

  /// Fetch staff from repository.
  Future<void> _fetchAll(
    SpecializationEvent$FetchAll event,
    Emitter<SpecializationState> emit,
  ) async {
    try {
      final specializations = await repository.getSpecializations();
      emit(SpecializationState.loaded(specializations: specializations));
    } on Object catch (e) {
      emit(
        SpecializationState.idle(
          specializations: state.specializations,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
