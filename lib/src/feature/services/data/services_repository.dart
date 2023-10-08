import 'package:ln_employee/src/feature/services/model/category.dart';

import 'services_data_provider.dart';

/// Repository for Services data.
abstract interface class ServicesRepository {
  /// Get ServicesDataProvider
  Future<List<CategoryModel>> getServiceCategories();
}

/// Implementation of the Services repository.
final class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl(this._dataProvider);

  /// Services data source.
  final ServicesDataProvider _dataProvider;

  @override
  Future<List<CategoryModel>> getServiceCategories() =>
      _dataProvider.fetchServiceCategories();
}
