import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class TimetableEmployeeScreen extends StatefulWidget {
  const TimetableEmployeeScreen({super.key, required this.id});

  ///
  final int id;

  @override
  State<TimetableEmployeeScreen> createState() =>
      _TimetableEmployeeScreenState();
}

class _TimetableEmployeeScreenState extends State<TimetableEmployeeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Расписание',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverList.list(
            children: const [
              // CustomTableCalendar(focusedDay: focusedDay),
            ],
          ),
        ],
      ),
    );
  }
}
