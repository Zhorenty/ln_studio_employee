import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/feature/book_history/model/timeblock.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_event.dart';

///
class TimeblocksWrap extends StatefulWidget {
  const TimeblocksWrap({
    super.key,
    required this.timeBlocks,
    this.visible = false,
    this.expanded = false,
    required this.timetableId,
  });

  ///
  final bool visible;

  ///
  final bool expanded;

  final int timetableId;

  ///
  final List<EmployeeTimeblock$Response> timeBlocks;

  @override
  State<TimeblocksWrap> createState() => _TimeblocksWrapState();
}

class _TimeblocksWrapState extends State<TimeblocksWrap> {
  late final TimeblockBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = TimeblockBloc(DependenciesScope.of(context).timetableRepository);
  }

  final List<int> timeblockIds = [];

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      alignment: widget.expanded ? Alignment.topCenter : Alignment.topCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: widget.visible ? 1 : 0,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF272727)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ...widget.timeBlocks.map(
                (timeblock) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedButton(
                    onPressed: () => timeblockIds.add(timeblock.id),
                    child: Chip(
                      backgroundColor: context.colorScheme.primary,
                      side: const BorderSide(color: Color(0xFF272727)),
                      label: Text(
                        timeblock.time.substring(0, timeblock.time.length - 3),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onBackground,
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () => bloc.add(
                  TimeblockEvent.add(
                    timetableId: widget.timetableId,
                    timeblockIds: timeblockIds,
                  ),
                ),
                child: const Text('Готово'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
