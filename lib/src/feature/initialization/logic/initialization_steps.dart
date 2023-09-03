import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ln_employee/src/feature/shedule/data/timetable_datasource.dart';
import 'package:ln_employee/src/feature/shedule/data/timetable_repository.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/initialization/model/initialization_progress.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Timetable repository & Rest client': (progress) async {
      final restClient = RestClient(
        Dio(
          BaseOptions(baseUrl: 'http://31.129.104.75'),
        ),
      );

      final TimetableDatasource timetableDatasource = TimetableDatasourceImpl(
        restClient: restClient,
      );

      final profileARepository = TimetableRepositoryImpl(
        dataSource: timetableDatasource,
      );
      progress.dependencies.timetableRepository = profileARepository;
    },
  };
}
