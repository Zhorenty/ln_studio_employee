import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/staff/data/staff_repository.dart';
import 'staff_event.dart';
import 'staff_state.dart';

/// Staff bloc.
class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc({required this.staffRepository}) : super(const StaffState.idle()) {
    on<StaffEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetchAllEmoloyees(event, emit),
        fetchSalonEmployees: (event) => _fetchSalonEmployees(event, emit),
      ),
    );
  }

  /// Repository for staff data.
  final StaffRepository staffRepository;

  /// Fetch staff from repository.
  Future<void> _fetchAllEmoloyees(
    StaffEvent$Fetch event,
    Emitter<StaffState> emit,
  ) async {
    try {
      final employees = await staffRepository.getStaff();
      emit(StaffState.loaded(employeeStaff: employees));
    } on Object catch (e) {
      emit(StaffState.idle(
        employeeStaff: state.employeeStaff,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Fetch staff from repository.
  Future<void> _fetchSalonEmployees(
    StaffEvent$FetchSalonEmployees event,
    Emitter<StaffState> emit,
  ) async {
    try {
      final employees =
          await staffRepository.fetchSalonEmployees(event.salonId);
      emit(StaffState.loaded(employeeStaff: employees));
    } on Object catch (e) {
      emit(StaffState.idle(
        employeeStaff: state.employeeStaff,
        error: e.toString(),
      ));
      rethrow;
    }
  }
}
