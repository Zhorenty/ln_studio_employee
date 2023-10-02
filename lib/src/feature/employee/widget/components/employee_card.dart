import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/common/widget/avatar_widget.dart';
import 'package:ln_employee/src/common/widget/star_rating.dart';
import 'package:ln_employee/src/feature/employee/bloc/staff/staff_bloc.dart';
import 'package:ln_employee/src/feature/employee/model/employee/employee.dart';

///
class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee, this.refresh});

  ///
  final Employee employee;

  ///
  final void Function()? refresh;

  @override
  Widget build(BuildContext context) {
    final user = employee.userModel;
    final jobPlace = employee.jobModel;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          AvatarWidget(radius: 40, title: user.fullName),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.fullName,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  jobPlace.name,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                StarRating(initialRating: employee.stars)
              ],
            ),
          ),
          AnimatedButton(
            onPressed: () => context.goNamed(
              'employee',
              extra: context.read<StaffBloc>(),
              pathParameters: {
                'id': employee.id.toString(),
              },
            ),
            child: Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: context.colorScheme.primary,
              ),
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.edit,
                size: 21,
                color: context.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
