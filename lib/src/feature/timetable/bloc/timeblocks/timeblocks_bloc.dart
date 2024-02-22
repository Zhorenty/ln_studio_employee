import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/utils/error_util.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_event.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_state.dart';
import 'package:ln_employee/src/feature/timetable/data/timetable_repository.dart';

class TimeblockBloc extends Bloc<TimeblockEvent, TimeblocksState> {
  TimeblockBloc(this.timetableRepository)
      : super(const TimeblocksState$Idle(data: null)) {
    on<TimeblockEvent>(
      (event, emit) => event.map(
        fetch: (e) => _fetch(e, emit),
        toggle: (e) => _toggle(e, emit),
      ),
    );
  }

  final TimetableRepository timetableRepository;

  Future<void> _fetch(
    TimeblockEvent$Fetch event,
    Emitter<TimeblocksState> emit,
  ) async {
    emit(TimeblocksState.processing(data: state.data));
    try {
      final timeblocks = await timetableRepository.getTimetableTimeblocks(
        timetableId: event.timetableId,
        timeblockId: event.timeblockId,
      );
      emit(TimeblocksState.successful(data: timeblocks));
    } on Object catch (e) {
      emit(TimeblocksState.error(
        data: state.data,
        message: ErrorUtil.formatError(e),
      ));
      rethrow;
    } finally {
      emit(TimeblocksState.idle(data: state.data));
    }
  }

  Future<void> _toggle(
    TimeblockEvent$Toggle event,
    Emitter<TimeblocksState> emit,
  ) async {
    emit(TimeblocksState.processing(data: state.data));
    try {
      await timetableRepository.toggleTimeblock(
        timetableId: event.timetableId,
        timeblockId: event.timeblockId,
        onWork: event.onWork,
      );
      final timeblocks = state.data
          ?.map((e) =>
              e.id == event.timeblockId ? e.copyWith(onWork: event.onWork) : e)
          .toList();
      emit(TimeblocksState.successful(data: timeblocks));
    } on Object catch (e) {
      emit(TimeblocksState.error(
        data: state.data,
        message: ErrorUtil.formatError(e),
      ));
      rethrow;
    } finally {
      emit(TimeblocksState.idle(data: state.data));
    }
  }
}
