import 'package:ln_employee/src/feature/services/model/category.dart';
import 'package:rest_client/rest_client.dart';

/// Datasource for Services ServicesDataProvider.
abstract interface class ServicesDataProvider {
  /// Fetch ServicesServicesDataProvider
  Future<List<CategoryModel>> fetchServiceCategories();
}

/// Implementation of Services ServicesDataProvider.
class ServicesDataProviderImpl implements ServicesDataProvider {
  ServicesDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<CategoryModel>> fetchServiceCategories() async {
    final response = await restClient.get('/api/v1/category/with_services');

    final categories = List.from((response['data'] as List))
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return categories;
  }
}
