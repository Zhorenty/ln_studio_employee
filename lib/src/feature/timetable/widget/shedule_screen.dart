import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timetable_bloc.dart';
import 'package:ln_employee/src/feature/timetable/widget/worker_widget.dart';

import '../bloc/timetable_state.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// {@template shedule_screen}
/// Shedule screen.
/// {@endtemplate}
class SheduleScreen extends StatelessWidget {
  /// {@macro shedule_screen}
  const SheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          backgroundColor: context.colors.onBackground,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(right: 2, top: 8),
              child: Text(
                'График работы',
                style: context.fonts.titleLarge?.copyWith(
                  color: context.colors.primary,
                  fontFamily: FontFamily.playfair,
                ),
              ),
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
        body: const CalendarScreen(),
      ),
    );
  }
}
