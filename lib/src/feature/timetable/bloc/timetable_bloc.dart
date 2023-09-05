import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/timetable/data/timetable_repository.dart';
import 'timetable_event.dart';
import 'timetable_state.dart';

/// Timetable bloc.
class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc({required this.timetableRepository})
      : super(const TimetableState.idle()) {
    on<TimetableEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetch(event, emit),
        fillTimetables: (event) => _fillTimetable(event, emit),
      ),
    );
  }

  /// Repository for timetables data
  final TimetableRepository timetableRepository;

  /// Fetch timetables from repository.
  Future<void> _fetch(
    TimetableEvent$Fetch event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      final employeeTimetable =
          await timetableRepository.getEmployeesTimetables();
      emit(TimetableState.loaded(employeeTimetable: employeeTimetable));
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Fill timetable items from repository.
  Future<void> _fillTimetable(
    TimetableEvent$FillTimetables event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      await timetableRepository.fillTimetable(event.fillTimetables);
      add(const TimetableEvent.fetch());
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }
}
