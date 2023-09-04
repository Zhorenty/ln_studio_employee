import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/timetable_repository.dart';
import 'shedule_event.dart';
import 'shedule_state.dart';

/// Wardrobe bloc.
class SheduleBloc extends Bloc<SheduleEvent, SheduleState> {
  SheduleBloc({required this.timetableRepository})
      : super(const SheduleState.idle()) {
    on<SheduleEvent>(
      (event, emit) => event.map(fetch: (e) => _load(e, emit)),
    );
  }

  ///
  final TimetableRepository timetableRepository;

  Future<void> _load(
      SheduleEvent$Fetch event, Emitter<SheduleState> emit) async {
    try {
      final timetables = await timetableRepository.fetchEmployeesTimetables();
      return emit(
        SheduleState.loaded(timetables: timetables),
      );
    } on Object catch (e) {
      emit(SheduleState.idle(error: e.toString()));
      rethrow;
    }
  }
}
