import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/shedule/bloc/shedule_bloc.dart';

import '../bloc/shedule_state.dart';
import '/src/common/utils/extensions/context_extension.dart';
import 'woker_test.dart';

/// {@template shedule_screen}
/// Shedule screen.
/// {@endtemplate}
class SheduleScreen extends StatelessWidget {
  /// {@macro shedule_screen}
  const SheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheduleBloc, SheduleState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          backgroundColor: context.colors.onBackground,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2, top: 8),
                  child: Text(
                    'ул. Степана Разина, д. 72',
                    style: context.fonts.bodyMedium?.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4, top: 8),
                  child: Icon(Icons.arrow_forward_ios, size: 12),
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: context.colors.primary,
                child: Icon(
                  Icons.person,
                  color: context.colors.onBackground,
                ),
              ),
            ),
          ],
        ),
        body: const ScheduleScreenTest(),
        // body: Center(
        //   child: Text(state.hasTimetables ? 'Hello' : 'Goodbye'),
        // ),
      ),
    );
  }
}
