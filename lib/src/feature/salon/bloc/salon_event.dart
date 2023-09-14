import 'package:ln_employee/src/feature/salon/models/salon.dart';

/// Business Logic Component salon_event Events
sealed class SalonEvent {
  const SalonEvent();

  /// Create
  // const factory SalonEvent.create({required ItemData itemData}) = SalonEvent;

  /// Fetch
  const factory SalonEvent.fetchAll() = SalonEvent$FetchAll;

  /// Save current
  const factory SalonEvent.saveCurrent(Salon salon) = SalonEvent$SaveCurrent;

  // /// Fetch
  // const factory SalonEvent.fetch({required int id}) = SalonEvent;

  /// Update
  // const factory SalonEvent.update({required Item item}) = SalonEvent;

  /// Delete
  // const factory SalonEvent.delete({required Item item}) = SalonEvent;
}

class SalonEvent$FetchAll extends SalonEvent {
  const SalonEvent$FetchAll();
}

class SalonEvent$SaveCurrent extends SalonEvent {
  const SalonEvent$SaveCurrent(this.salon);

  final Salon salon;
}
