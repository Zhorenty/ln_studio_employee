import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_event.dart';
import 'package:ln_employee/src/feature/employee/widget/employee_screen.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/employee/widget/edit_employee_screen.dart';
import '/src/feature/employee/widget/staff_screen.dart';
import '/src/feature/profile/widget/profile_screen.dart';
import '/src/feature/timetable/widget/timetable_screen.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

/// Router of this application.
final router = GoRouter(
  initialLocation: '/timetable',
  navigatorKey: _parentKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => CustomBottomNavigationBar(
        navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/timetable',
              builder: (context, state) => const TimetableScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/staff',
              builder: (context, state) => const StaffScreen(),
              routes: [
                ShellRoute(
                  parentNavigatorKey: _parentKey,
                  navigatorKey: _shellKey,
                  builder: (context, state, child) => BlocProvider(
                    create: (context) => EmployeeBloc(
                      repository:
                          DependenciesScope.of(context).employeeRepository,
                    )..add(
                        EmployeeEvent.fetch(
                          id: int.parse(state.pathParameters['id'] as String),
                        ),
                      ),
                    child: child,
                  ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _shellKey,
                      name: 'employee',
                      path: ':id',
                      builder: (context, state) => EmployeeScreen(
                        id: int.parse(state.pathParameters['id'] as String),
                      ),
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _shellKey,
                          name: 'employee_edit',
                          path: 'edit',
                          builder: (context, state) => EditEmployeeScreen(
                            id: int.parse(state.pathParameters['id'] as String),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
