import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/auth/widget/auth_screen.dart';
import 'package:ln_employee/src/feature/auth/widget/unregistered_screen.dart';
import 'package:ln_employee/src/feature/auth/widget/verification_screen.dart';
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
  initialLocation: '/auth',
  navigatorKey: _parentKey,
  routes: [
    GoRoute(
      name: 'auth',
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
      routes: [
        GoRoute(
          name: 'verify',
          path: 'verify',
          builder: (context, state) => const VerificationScreen(),
          routes: [
            GoRoute(
              name: 'unregistered',
              path: 'unregistered',
              builder: (context, state) => const UnregisteredScreen(),
            ),
          ],
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => CustomBottomNavigationBar(
        navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/timetable',
              name: 'timetable',
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
                      pageBuilder: (context, state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: EmployeeScreen(
                            id: int.parse(state.pathParameters['id'] as String),
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            final tween = Tween(begin: begin, end: end);
                            final offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              transformHitTests: false,
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        );
                      },
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
