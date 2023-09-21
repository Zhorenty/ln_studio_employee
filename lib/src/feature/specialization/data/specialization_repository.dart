import '/src/feature/specialization/data/specialization_data_provider.dart';
import '/src/feature/specialization/model/specialization.dart';

/// Repository for staff data.
abstract interface class SpecializationRepository {
  /// Get staff.
  Future<List<Specialization>> getSpecializations();
}

/// Implementation of the staff repository.
final class SpecializationRepositoryImpl implements SpecializationRepository {
  SpecializationRepositoryImpl(this._dataSource);

  /// Specialization data source.
  final SpecializationDataProvider _dataSource;

  @override
  Future<List<Specialization>> getSpecializations() =>
      _dataSource.fetchSpecializations();
}
