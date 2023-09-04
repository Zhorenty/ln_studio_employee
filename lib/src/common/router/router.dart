import 'package:go_router/go_router.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/settings/widget/settings_screen.dart';
import '../../feature/timetable/widget/timetable_screen.dart';

/// Router of this application.
final router = GoRouter(
  initialLocation: '/timetable',
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
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
