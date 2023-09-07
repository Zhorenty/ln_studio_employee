import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/router/app_router_scope.dart';
import '../../employee/bloc/employee_bloc.dart';
import '../../timetable/bloc/timetable_bloc.dart';
import '../../timetable/bloc/timetable_event.dart';
import '/src/common/widget/scope_widgets.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/initialization/model/dependencies.dart';
import 'app_context.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  void run() => runApp(this);

  /// Handles initialization result.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TimetableBloc(
              timetableRepository: result.dependencies.timetableRepository,
            )..add(const TimetableEvent.fetch()),
          ),
          BlocProvider(
            create: (context) => EmployeeBloc(
              employeeRepository: result.dependencies.employeeRepository,
            ),
          ),
        ],
        child: ScopesProvider(
          providers: [
            ScopeProvider(
              buildScope: (child) => DependenciesScope(
                dependencies: result.dependencies,
                child: child,
              ),
            ),
            ScopeProvider(
              buildScope: (child) => AppRouterScope(
                child: child,
              ),
            ),
          ],
          child: const AppContext(),
        ),
      );
}
