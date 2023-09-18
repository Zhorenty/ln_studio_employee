import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/all_employee/widget/staff_screen.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '../../feature/edit_employee/widget/employee_screen.dart';
import '/src/feature/settings/widget/settings_screen.dart';
import '/src/feature/timetable/widget/timetable_screen.dart';

final _parentKey = GlobalKey<NavigatorState>();

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
                GoRoute(
                  path: 'employee',
                  parentNavigatorKey: _parentKey,
                  pageBuilder: (context, state) {
                    final id = state.extra as int;
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: EmployeeScreen(employeeid: id),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        final tween = Tween(begin: begin, end: end);
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
