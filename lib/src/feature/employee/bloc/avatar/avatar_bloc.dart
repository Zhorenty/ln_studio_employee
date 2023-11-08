import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_employee/src/feature/employee/bloc/avatar/avatar_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/avatar/avatar_state.dart';
import 'package:ln_employee/src/feature/employee/data/employee_repository.dart';

/// Business Logic Component EmployeeAvatarBloc
class EmployeeAvatarBloc
    extends Bloc<EmployeeAvatarEvent, EmployeeAvatarState> {
  EmployeeAvatarBloc({
    required final EmployeeRepository repository,
    final EmployeeAvatarState? initialState,
  })  : _repository = repository,
        super(initialState ?? const EmployeeAvatarState.idle()) {
    on<EmployeeAvatarEvent>(
      (event, emit) => switch (event) {
        EmployeeAvatarEvent$UploadAvatar() => _uploadPhoto(event, emit),
      },
    );
  }

  ///
  final EmployeeRepository _repository;

  /// Fetch event handler
  Future<void> _uploadPhoto(
    EmployeeAvatarEvent$UploadAvatar event,
    Emitter<EmployeeAvatarState> emit,
  ) async {
    emit(EmployeeAvatarState.processing(imageUrl: state.imageUrl));
    try {
      await _repository.uploadAvatar(id: event.id, avatar: event.file);
      emit(EmployeeAvatarState.successful(imageUrl: state.imageUrl));
    } on Object catch (err, _) {
      emit(EmployeeAvatarState.idle(error: err.toString()));
      rethrow;
    }
  }
}
