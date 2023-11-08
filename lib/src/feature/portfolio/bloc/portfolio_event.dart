import 'dart:io';

/// Business Logic Component Portfolio_event Events
sealed class PortfolioEvent {
  const PortfolioEvent();

  /// Fetch
  const factory PortfolioEvent.fetch({required int id}) = PortfolioEvent$Fetch;

  const factory PortfolioEvent.addPhoto({
    required int id,
    required File photo,
  }) = PortfolioEvent$AddPhoto;

  const factory PortfolioEvent.delete({required int id}) =
      PortfolioEvent$Delete;
}

/// Fetch all Portfolio.
class PortfolioEvent$Fetch extends PortfolioEvent {
  const PortfolioEvent$Fetch({required this.id});

  final int id;
}

///
class PortfolioEvent$AddPhoto extends PortfolioEvent {
  const PortfolioEvent$AddPhoto({required this.photo, required this.id});

  final int id;

  ///
  final File photo;
}

///
class PortfolioEvent$Delete extends PortfolioEvent {
  const PortfolioEvent$Delete({required this.id});

  final int id;
}
