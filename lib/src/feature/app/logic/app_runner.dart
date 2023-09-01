import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/src/common/bloc/observer.dart';
import '/src/common/utils/logger.dart';
import '/src/feature/app/widget/app.dart';
import '/src/feature/initialization/logic/initialization_processor.dart';
import '/src/feature/initialization/logic/initialization_steps.dart';
import '/src/feature/initialization/model/initialization_hook.dart';

/// Class which is responsible for initialization and running the app.
class AppRunner with InitializationSteps, InitializationProcessor {
  /// run initialization
  ///
  /// if success -> run app
  Future<void> initializeAndRun(InitializationHook hook) async {
    final bindings = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();
    FlutterError.onError = logger.logFlutterError;
    PlatformDispatcher.instance.onError = logger.logPlatformDispatcherError;
    Bloc.observer = AppBlocObserver();
    Bloc.transformer = sequential();

    /// TODO(zhorenty): Remove after splash is approved
    /// Splash screen test
    Future initialization(BuildContext ctx) async =>
        await Future.delayed(const Duration(seconds: 5));

    // ignore: deprecated_member_use
    FlutterNativeSplash.removeAfter(initialization);

    final result = await processInitialization(
      steps: initializationSteps,
      hook: hook,
    );
    bindings.addPostFrameCallback((_) => bindings.allowFirstFrame());

    // Run application
    App(result: result).run();
  }
}
