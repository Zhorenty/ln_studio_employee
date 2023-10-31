import 'package:flutter/material.dart';

import '/src/common/utils/logger.dart';

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final buffer = StringBuffer()
      ..writeln('Route pushed: ${route.settings.name?.toUpperCase()}');
    logger.info(buffer);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    final buffer = StringBuffer()
      ..writeln('Route replaced: ${newRoute?.settings.name?.toUpperCase()}');
    logger.info(buffer);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final buffer = StringBuffer()
      ..writeln('Route popped: ${route.settings.name?.toUpperCase()}');
    logger.info(buffer);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    final buffer = StringBuffer()
      ..writeln('Route removed: ${route.settings.name?.toUpperCase()}');
    logger.info(buffer);
  }
}
