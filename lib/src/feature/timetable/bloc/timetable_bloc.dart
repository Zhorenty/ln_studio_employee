import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/timetable_repository.dart';
import 'timetable_event.dart';
import 'timetable_state.dart';

/// Wardrobe bloc.
class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc({required this.timetableRepository})
      : super(const TimetableState.idle()) {
    on<TimetableEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetch(event, emit),
        fillTimetables: (event) => _fillTimetables(event, emit),
        deleteTimetableItems: (event) => _deleteTimetableItems(event, emit),
      ),
    );
  }

  ///
  final TimetableRepository timetableRepository;

  Future<void> _fetch(
    TimetableEvent$Fetch event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      final employeeTimetable =
          await timetableRepository.fetchEmployeesTimetables();
      emit(TimetableState.loaded(employeeTimetable: employeeTimetable));
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _fillTimetables(
    TimetableEvent$FillTimetables event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      await timetableRepository.fillTimetables(event.fillTimetables);
      add(const TimetableEvent.fetch());
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _deleteTimetableItems(
    TimetableEvent$DeleteTimetableItems event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      await timetableRepository.deleteTimetableItems(event.timetableItems);
      emit(TimetableState.loaded(employeeTimetable: state.employeeTimetable));
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }
}
