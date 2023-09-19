import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_event.dart';

import '/src/common/router/app_router_scope.dart';
import '/src/common/widget/scope_widgets.dart';
import '/src/feature/employee/bloc/employee_bloc.dart';
import '/src/feature/initialization/model/dependencies.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/staff/bloc/staff_bloc.dart';
import '/src/feature/timetable/bloc/timetable_bloc.dart';

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
            ),
          ),
          BlocProvider(
            create: (context) => StaffBloc(
              staffRepository: result.dependencies.staffRepository,
            ),
          ),
          BlocProvider(
            create: (context) => EmployeeBloc(
              employeeRepository: result.dependencies.employeeRepository,
            ),
          ),
          BlocProvider(
            create: (context) => SalonBLoC(
              repository: result.dependencies.salonRepository,
            )..add(const SalonEvent.fetchAll()),
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
