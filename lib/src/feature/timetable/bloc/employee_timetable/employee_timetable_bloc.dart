import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_employee/src/common/utils/error_util.dart';
import 'package:ln_employee/src/common/utils/mixin/set_state_mixin.dart';
import 'package:ln_employee/src/feature/timetable/bloc/employee_timetable/employee_timetable_event.dart';
import 'package:ln_employee/src/feature/timetable/data/timetable_repository.dart';

import 'employee_timetable_state.dart';

class EmployeeTimetableBloc
    extends Bloc<EmployeeTimetableEvent, EmployeeTimetableState>
    with SetStateMixin {
  EmployeeTimetableBloc(this.repository)
      : super(const EmployeeTimetable$Idle(timetables: [])) {
    on<EmployeeTimetableEvent>(
      (event, emit) => event.map(
        fetchTimetable: (e) => _fetchTimetable(e, emit),
        fillTimetable: (event) => _fillTimetable(event, emit),
      ),
    );
  }

  final TimetableRepository repository;

  Future<void> _fetchTimetable(
    EmployeeTimetableEvent$FetchTimetable event,
    Emitter<EmployeeTimetableState> emit,
  ) async {
    emit(EmployeeTimetableState.processing(timetables: state.timetables));
    try {
      final timetables = await repository.fetchEmployeeTimetables(
        event.salonId,
        event.employeeId,
      );
      emit(EmployeeTimetableState.successful(
        timetables: timetables,
      ));
    } on Object catch (e) {
      emit(EmployeeTimetableState.idle(
        timetables: state.timetables,
        error: ErrorUtil.formatError(e),
      ));
      rethrow;
    }
  }

  /// Fill timetable items from repository.
  Future<void> _fillTimetable(
    EmployeeTimetableEvent$FillTimetables event,
    Emitter<EmployeeTimetableState> emit,
  ) async {
    try {
      await repository.fillTimetable(
        employeeId: event.employeeId,
        salonId: event.salonId,
        dateAt: event.dateAt,
      );
      final timetables = await repository.fetchEmployeeTimetables(
        event.salonId,
        event.employeeId,
      );
      emit(
        EmployeeTimetableState.successful(timetables: timetables),
      );
    } on Object catch (e) {
      emit(EmployeeTimetableState.idle(
        timetables: state.timetables,
        error: ErrorUtil.formatError(e),
      ));
      rethrow;
    }
  }
}
