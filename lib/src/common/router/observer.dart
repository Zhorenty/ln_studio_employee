import 'package:flutter/material.dart';

import '/src/common/utils/logger.dart';

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final buffer = StringBuffer()
      ..write('Route pushed: ')
      ..write(route.settings.name?.toUpperCase() ?? 'Modal');
    logger.info(buffer);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    final buffer = StringBuffer()
      ..write('Route replaced: ')
      ..write(newRoute?.settings.name?.toUpperCase() ?? 'Modal');
    logger.info(buffer);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final buffer = StringBuffer()
      ..write('Route popped: ')
      ..write(route.settings.name?.toUpperCase() ?? 'Modal');
    logger.info(buffer);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    final buffer = StringBuffer()
      ..write('Route removed: ')
      ..write(route.settings.name?.toUpperCase() ?? 'Modal');
    logger.info(buffer);
  }
}
