import 'dart:io';

import 'package:ln_employee/src/feature/portfolio/data/portfolio_data_provider.dart';

import '../model/portfolio.dart';

/// Datasource for Record NewsDataProvider.
abstract interface class PortfolioRepository {
  /// Fetch RecordHomeDataProvider
  Future<List<PortfolioModel>> getPortfolio(int id);

  Future<void> addPhoto(int id, File file);

  Future<void> deletePhoto(int id);
}

/// Implementation of the Record repository.
final class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this._dataProvider);

  /// Record data source.
  final PortfolioDataProvider _dataProvider;

  @override
  Future<void> addPhoto(int id, File file) => _dataProvider.addPhoto(id, file);

  @override
  Future<void> deletePhoto(int id) => _dataProvider.deletePhoto(id);

  @override
  Future<List<PortfolioModel>> getPortfolio(int id) =>
      _dataProvider.fetchPortfolio(id);
}
