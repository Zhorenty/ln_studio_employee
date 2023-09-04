import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/timetable_repository.dart';
import 'timetable_event.dart';
import 'timetable_state.dart';

/// Wardrobe bloc.
class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc({required this.timetableRepository})
      : super(const TimetableState.idle()) {
    on<TimetableEvent>(
      (event, emit) => event.map(fetch: (e) => _load(e, emit)),
    );
  }

  ///
  final TimetableRepository timetableRepository;

  Future<void> _load(
      TimetableEvent$Fetch event, Emitter<TimetableState> emit) async {
    try {
      final timetables = await timetableRepository.fetchEmployeesTimetables();
      return emit(
        TimetableState.loaded(timetables: timetables),
      );
    } on Object catch (e) {
      emit(TimetableState.idle(error: e.toString()));
      rethrow;
    }
  }
}
