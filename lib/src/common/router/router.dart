import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/auth/widget/auth_scope.dart';
import 'package:ln_employee/src/feature/auth/widget/auth_screen.dart';
import 'package:ln_employee/src/feature/auth/widget/verification_screen.dart';
import 'package:ln_employee/src/feature/book_history/widget/booking_history_screen.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_event.dart';
import 'package:ln_employee/src/feature/employee/widget/employee_screen.dart';
import 'package:ln_employee/src/feature/employee/widget/timetable_employee_screen.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_employee/src/feature/news/bloc/news_bloc.dart';
import 'package:ln_employee/src/feature/news/bloc/news_event.dart';
import 'package:ln_employee/src/feature/news/model/news.dart';
import 'package:ln_employee/src/feature/news/widget/create_news_screen.dart';
import 'package:ln_employee/src/feature/news/widget/edit_news_screen.dart';
import 'package:ln_employee/src/feature/news/widget/news_screen.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/employee/widget/edit_employee_screen.dart';
import '/src/feature/employee/widget/staff_screen.dart';
import '/src/feature/profile/widget/profile_screen.dart';
import '/src/feature/timetable/widget/timetable_screen.dart';
import 'observer.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

/// Router of this application.
final router = GoRouter(
  observers: [RouterObserver()],
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
              builder: (context, state) {
                final authScope = AuthenticationScope.of(context);
                return authScope.isSuperuser
                    ? const TimetableScreen()
                    : BookingHistoryScreen(
                        id: authScope.user?.id ?? 1,
                      );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/staff',
              builder: (context, state) {
                final authScope = AuthenticationScope.of(context);
                return authScope.isSuperuser
                    ? const StaffScreen()
                    : TimetableEmployeeScreen(
                        employeeId: authScope.user?.id ?? 1,
                        salonId:
                            context.read<SalonBLoC>().state.currentSalon?.id ??
                                1,
                      );
              },
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
                        GoRoute(
                          parentNavigatorKey: _shellKey,
                          name: 'employee_timetable',
                          path: 'timetable/:salonId',
                          builder: (context, state) => TimetableEmployeeScreen(
                            employeeId:
                                int.parse(state.pathParameters['id'] as String),
                            salonId: int.parse(
                                state.pathParameters['salonId'] as String),
                          ),
                        ),
                        GoRoute(
                          parentNavigatorKey: _shellKey,
                          name: 'employee_clients',
                          path: 'clients',
                          builder: (context, state) => BookingHistoryScreen(
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
              routes: [
                ShellRoute(
                  parentNavigatorKey: _parentKey,
                  navigatorKey: _shellKey,
                  builder: (context, state, child) => BlocProvider(
                    create: (context) => NewsBLoC(
                      repository:
                          DependenciesScope.of(context).profileRepository,
                    )..add(const NewsEvent.fetchAll()),
                    child: child,
                  ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _shellKey,
                      name: 'news',
                      path: 'news',
                      builder: (context, state) => const NewsScreen(),
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _shellKey,
                          name: 'news_edit',
                          path: 'edit',
                          builder: (context, state) => EditNewsScreen(
                            news: state.extra as NewsModel,
                          ),
                        ),
                        GoRoute(
                          parentNavigatorKey: _shellKey,
                          name: 'news_create',
                          path: 'create',
                          builder: (context, state) => const CreateNewsScreen(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
