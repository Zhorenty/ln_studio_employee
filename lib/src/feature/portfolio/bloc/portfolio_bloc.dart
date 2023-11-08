// ignore_for_file: unused_element

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/portfolio/data/portfolio_repository.dart';

import 'portfolio_event.dart';
import 'potfolio_state.dart';

/// Business Logic Component PortfolioBloc
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc({
    required final PortfolioRepository repository,
    final PortfolioState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const PortfolioState.idle(
                portfolio: [],
                photo: null,
                message: 'Initial idle state',
              ),
        ) {
    on<PortfolioEvent>(
      (event, emit) => switch (event) {
        PortfolioEvent$Fetch() => _fetchAll(event, emit),
        PortfolioEvent$AddPhoto() => _uploadPhoto(event, emit),
        PortfolioEvent$Delete() => _delete(event, emit),
      },
    );
  }

  ///
  final PortfolioRepository _repository;

  /// Fetch event handler
  Future<void> _fetchAll(
    PortfolioEvent$Fetch event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(
      PortfolioState.processing(
        portfolio: state.portfolio,
        photo: state.photo,
      ),
    );
    try {
      final portfolio = await _repository.getPortfolio(event.id);
      emit(PortfolioState.successful(
        portfolio: portfolio,
        photo: state.photo,
      ));
    } on Object catch (err, _) {
      emit(PortfolioState.error(
        portfolio: state.portfolio,
        photo: state.photo,
      ));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _uploadPhoto(
    PortfolioEvent$AddPhoto event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(
      PortfolioState.processing(
        portfolio: state.portfolio,
        photo: state.photo,
      ),
    );
    try {
      await _repository.addPhoto(event.id, event.photo);
      emit(PortfolioState.successful(
        portfolio: state.portfolio,
        photo: event.photo,
      ));
    } on Object catch (err, _) {
      emit(PortfolioState.error(
        portfolio: state.portfolio,
        photo: state.photo,
      ));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _delete(
    PortfolioEvent$Delete event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(
      PortfolioState.processing(
        portfolio: state.portfolio,
        photo: state.photo,
      ),
    );
    try {
      await _repository.deletePhoto(event.id);
      emit(PortfolioState.successful(
        portfolio: state.portfolio,
        photo: state.photo,
      ));
    } on Object catch (err, _) {
      emit(PortfolioState.error(
        portfolio: state.portfolio,
        photo: state.photo,
      ));
      rethrow;
    }
  }
}
