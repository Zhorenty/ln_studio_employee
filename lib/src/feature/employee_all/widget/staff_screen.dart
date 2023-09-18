import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/employee_all/bloc/staff_bloc.dart';
import 'package:ln_employee/src/feature/employee_all/bloc/staff_event.dart';
import 'package:ln_employee/src/feature/employee_all/bloc/staff_state.dart';
import 'package:ln_employee/src/feature/employee/model/employee/employee.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/avatar_widget.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/overlay/modal_popup.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/create_employee/widget/create_employee_screen.dart';

/// {@template staff_screen}
/// Staff screen.
/// {@endtemplate}
class StaffScreen extends StatefulWidget {
  /// {@macro staff_screen}
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
    controller.reverseDuration = const Duration(milliseconds: 350);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) => Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(title: context.stringOf().employees),
            CupertinoSliverRefreshControl(onRefresh: _refresh),
            if (state.hasStaff) ...[
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: _EmployeeList(
                  staff: state.employeeStaff,
                  refresh: _refresh,
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => ModalPopup.show(
                    context: context,
                    showDivider: false,
                    transitionAnimationController: controller,
                    child: const CreateEmployeeScreen(),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width / 8,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        context.stringOf().addEmployee,
                        style: context.textTheme.titleMedium!.copyWith(
                          color: context.colorScheme.background,
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const Divider(),
                      Text(
                        'Уволенные сотрудники',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: _EmployeeList(
                  isDismiss: true,
                  staff: state.employeeStaff,
                  refresh: _refresh,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.sizeOf(context).height / 8),
              ),
            ] else
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    context.stringOf().noEmployees,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: !state.hasStaff
            ? FloatingActionButton.extended(
                backgroundColor: context.colorScheme.primary,
                label: Text(
                  context.stringOf().addEmployee,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.background,
                  ),
                ),
                onPressed: () {},
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Future<void> _refresh() async {
    final block = context.read<StaffBloc>().stream.first;
    context.read<StaffBloc>().add(const StaffEvent.fetch());
    await block;
  }
}

// TODO(zhorenty): Refactor
class _EmployeeList extends StatelessWidget {
  const _EmployeeList({
    required this.staff,
    this.refresh,
    this.isDismiss = false,
  });

  ///
  final List<Employee> staff;

  ///
  final bool isDismiss;

  ///
  final void Function()? refresh;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: staff.length,
      itemBuilder: (context, index) {
        final employee = staff[index];
        final user = staff[index].userModel;
        final jobPlace = staff[index].jobModel;

        return employee.isDismiss == isDismiss
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 4 + 2),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 4,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarWidget(
                      radius: 40,
                      title: '${user.firstName} ${user.lastName}',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8 + 2),
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
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
                    const SizedBox.shrink(),
                    AnimatedButton(
                      onPressed: () {
                        refresh;
                        context.go('/staff/employee', extra: employee.id);
                      },
                      child: const Icon(Icons.edit, size: 20),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
