import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/staff/model/employee.dart';
import 'package:ln_employee/src/feature/staff/widget/staff_screen.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/employee/widget/employee_screen.dart';
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
                  builder: (context, state) {
                    final employee = state.extra as EmployeeModel;
                    return EmployeeScreen(employee: employee);
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
