import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/utils/error_util.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_event.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_state.dart';
import 'package:ln_employee/src/feature/timetable/data/timetable_repository.dart';

class TimeblockBloc extends Bloc<TimeblockEvent, TimeblocksState> {
  TimeblockBloc(this.timetableRepository)
      : super(const TimeblocksState$Idle(data: null)) {
    on<TimeblockEvent>(
      (event, emit) => event.map(add: (e) => _add(e, emit)),
    );
  }

  final TimetableRepository timetableRepository;

  Future<void> _add(
    TimeblockEvent$Add event,
    Emitter<TimeblocksState> emit,
  ) async {
    emit(const TimeblocksState.processing(data: null));
    try {
      await timetableRepository.addTimeblock(
        timetableId: event.timetableId,
        timeblockIds: event.timeblockIds,
      );
      emit(const TimeblocksState.successful(data: null));
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
