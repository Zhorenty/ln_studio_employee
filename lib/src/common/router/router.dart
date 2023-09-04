import 'package:go_router/go_router.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/settings/widget/settings_screen.dart';
import '../../feature/timetable/widget/shedule_screen.dart';

/// Router of this application.
final router = GoRouter(
  initialLocation: '/shedule',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => CustomBottomNavigationBar(
        navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shedule',
              builder: (context, state) => const SheduleScreen(),
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
