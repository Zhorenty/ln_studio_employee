import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/timetable/data/timetable_repository.dart';
import 'timetable_event.dart';
import 'timetable_state.dart';

/// Timetable bloc.
class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc({required this.repository})
      : super(const TimetableState.idle()) {
    on<TimetableEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetch(event, emit),
        fetchBySalonId: (event) => _fetchBySalonId(event, emit),
        fillTimetable: (event) => _fillTimetable(event, emit),
      ),
    );
  }

  /// Repository for timetables data
  final TimetableRepository repository;

  /// Fetch timetables from repository.
  Future<void> _fetch(
    TimetableEvent$Fetch event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      final employeeTimetable = await repository.getTimetables();
      emit(TimetableState.loaded(employeeTimetable: employeeTimetable));
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Fetch timetables from repository.
  Future<void> _fetchBySalonId(
    TimetableEvent$FetchBySalonId event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      final employeeTimetable = await repository.getTimetablesBySalonId(
        event.salonId,
      );
      emit(TimetableState.loaded(employeeTimetable: employeeTimetable));
    } on Object catch (e) {
      emit(TimetableState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }

  /// Fill timetable items from repository.
  Future<void> _fillTimetable(
    TimetableEvent$FillTimetables event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      await repository.fillTimetable(
        employeeId: event.employeeId,
        salonId: event.salonId,
        dateAt: event.dateAt,
      );
      final employeeTimetable =
          await repository.getTimetablesBySalonId(event.salonId);
      emit(TimetableState.loaded(employeeTimetable: employeeTimetable));
    } on Object catch (e) {
      emit(TimetableState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }
}
