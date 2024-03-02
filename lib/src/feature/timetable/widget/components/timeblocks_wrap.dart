import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_event.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timeblocks/timeblocks_state.dart';

///
class TimeblocksWrap extends StatefulWidget {
  const TimeblocksWrap({
    super.key,
    required this.timetableId,
  });

  final int timetableId;

  @override
  State<TimeblocksWrap> createState() => _TimeblocksWrapState();
}

class _TimeblocksWrapState extends State<TimeblocksWrap> {
  late final TimeblockBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = TimeblockBloc(DependenciesScope.of(context).timetableRepository)
      ..add(
        TimeblockEvent.fetch(
          timetableId: widget.timetableId,
          timeblockId: 1,
        ),
      );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeblockBloc, TimeblocksState>(
        bloc: bloc,
        builder: (context, state) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: state.hasData
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF272727)),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ...state.data?.map(
                          (timeblock) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedButton(
                              onPressed: () => bloc.add(
                                TimeblockEvent.toggle(
                                  timetableId: widget.timetableId,
                                  timeblockId: timeblock.id,
                                  onWork: !timeblock.onWork,
                                ),
                              ),
                              child: Chip(
                                backgroundColor: timeblock.onWork
                                    ? context.colorScheme.primary
                                    : context.colorScheme.onBackground,
                                side:
                                    const BorderSide(color: Color(0xFF272727)),
                                label: Text(
                                  timeblock.time
                                      .substring(0, timeblock.time.length - 3),
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: timeblock.onWork
                                        ? context.colorScheme.onBackground
                                        : context.colorScheme.secondary,
                                    fontFamily: FontFamily.geologica,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ) ??
                        [],
                  ],
                ),
              ),
              secondChild: const CircularProgressIndicator.adaptive(),
            ),
          );
        });
  }
}
