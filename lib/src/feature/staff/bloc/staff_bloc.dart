import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/staff_repository.dart';
import 'staff_event.dart';
import 'staff_state.dart';

/// Staff bloc.
class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc({required this.staffRepository}) : super(const StaffState.idle()) {
    on<StaffEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetch(event, emit),
      ),
    );
  }

  /// Repository for Staffs data
  final StaffRepository staffRepository;

  /// Fetch Staffs from repository.
  Future<void> _fetch(
    StaffEvent$Fetch event,
    Emitter<StaffState> emit,
  ) async {
    try {
      final employeeStaff = await staffRepository.getStaff();
      emit(StaffState.loaded(employeeStaff: employeeStaff));
    } on Object catch (e) {
      emit(StaffState.idle(error: e.toString()));
      rethrow;
    }
  }
}
