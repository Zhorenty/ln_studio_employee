import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/feature/book_history/model/timeblock.dart';

///
class TimeblocksWrap extends StatelessWidget {
  const TimeblocksWrap({
    super.key,
    required this.timeBlocks,
    this.visible = false,
    this.expanded = false,
  });

  ///
  final bool visible;

  ///
  final bool expanded;

  ///
  final List<EmployeeTimeblock$Response> timeBlocks;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      alignment: expanded ? Alignment.topCenter : Alignment.topCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: visible ? 1 : 0,
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
              ...timeBlocks.map(
                (timeblock) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedButton(
                    // TODO: Работать с таймблоками
                    onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
