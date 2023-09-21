import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/avatar_widget.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/overlay/modal_popup.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/employee/model/employee/employee.dart';
import '/src/feature/employee_all/bloc/staff_bloc.dart';
import '/src/feature/employee_all/bloc/staff_event.dart';
import '/src/feature/employee_all/bloc/staff_state.dart';
import '/src/feature/employee_create/widget/create_employee_screen.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';

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
  /// Controller for an [ModalPopup.show] animation.
  late AnimationController controller;

  /// Staff bloc maintaining [StaffScreen] state.
  late final StaffBloc staffBloc;

  @override
  void initState() {
    super.initState();
    staffBloc = context.read<StaffBloc>();
    _fetchSalonEmployees();
    initController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBLoC, SalonState>(
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (previous.currentSalon?.id != current.currentSalon?.id) {
          staffBloc.add(
            StaffEvent.fetchSalonEmployees(current.currentSalon!.id),
          );
        }
        return false;
      },
      child: BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) => Scaffold(
          body: CustomScrollView(
            slivers: [
              CustomSliverAppBar(
                title: context.stringOf().employees,
                actions: [
                  AnimatedButton(
                    padding: const EdgeInsets.only(right: 8 + 2, top: 2),
                    child: Icon(
                      Icons.person_add,
                      color: context.colorScheme.primary,
                    ),
                    onPressed: () {
                      ModalPopup.show(
                        context: context,
                        showDivider: false,
                        transitionAnimationController: controller,
                        child: const CreateEmployeeScreen(),
                      );
                    },
                  ),
                ],
              ),
              CupertinoSliverRefreshControl(onRefresh: _refresh),
              if (state.hasStaff) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.builder(
                    itemCount: state.staff.length,
                    itemBuilder: (context, index) {
                      final employee = state.staff[index];

                      if (employee.isDismiss == false) {
                        return EmployeeCard(
                          employee: employee,
                          refresh: _refresh,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: MediaQuery.sizeOf(context).height / 8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ExpansionTile(
                      title: const Text('Уволенные сотрудники'),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.staff.length,
                          itemBuilder: (context, index) {
                            final employee = state.staff[index];

                            if (employee.isDismiss) {
                              return EmployeeCard(
                                employee: employee,
                                refresh: _refresh,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
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
                    style: context.textTheme.bodySmall!.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.background,
                    ),
                  ),
                  onPressed: () {},
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
    controller.reverseDuration = const Duration(milliseconds: 350);
  }

  void _fetchSalonEmployees() {
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      staffBloc.add(
        StaffEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
  }

  Future<void> _refresh() async {
    final block = context.read<StaffBloc>().stream.first;
    _fetchSalonEmployees();
    await block;
  }
}

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
          AvatarWidget(
            radius: 40,
            title: '${user.firstName} ${user.lastName}',
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.9,
                child: Text(
                  '${user.firstName} ${user.lastName}',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          AnimatedButton(
            onPressed: () => context.go('/staff/employee', extra: employee.id),
            child: Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: context.colorScheme.primary,
              ),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.edit,
                size: 18,
                color: context.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
