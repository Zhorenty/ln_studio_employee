import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/services/widget/services_screen.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/employee/bloc/staff/staff_bloc.dart';
import '/src/feature/employee/widget/edit_employee_screen.dart';
import '/src/feature/employee/widget/staff_screen.dart';
import '/src/feature/profile/widget/profile_screen.dart';
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
                  name: 'employee',
                  path: 'employee/:id',
                  parentNavigatorKey: _parentKey,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: EditEmployeeScreen(
                        id: int.parse(state.pathParameters['id'] as String),
                        staffBloc: state.extra as StaffBloc,
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
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'profile',
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  name: 'services',
                  path: 'services',
                  builder: (context, state) => const ServicesScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
