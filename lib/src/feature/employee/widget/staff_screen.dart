import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/overlay/modal_popup.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/feature/employee/bloc/staff/staff_bloc.dart';
import '/src/feature/employee/bloc/staff/staff_event.dart';
import '/src/feature/employee/bloc/staff/staff_state.dart';
import '/src/feature/employee/widget/components/employee_card.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/widget/salon_choice_screen.dart';
import 'create_employee_screen.dart';

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
                      color: context.colorScheme.secondary,
                    ),
                    onPressed: () => ModalPopup.show(
                      context: context,
                      showDivider: false,
                      transitionAnimationController: controller,
                      mobilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const CreateEmployeeScreen(),
                    ),
                  ),
                ],
                bottomChild: BlocBuilder<SalonBLoC, SalonState>(
                  builder: (context, state) => state.currentSalon != null
                      ? PopupButton(
                          label: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.currentSalon != null
                                ? Text(state.currentSalon!.name)
                                : const SizedBox(height: 26),
                          ),
                          child: SalonChoiceScreen(
                            currentSalon: state.currentSalon,
                          ),
                        )
                      : const SkeletonPopUpButton(),
                ),
              ),
              CupertinoSliverRefreshControl(onRefresh: _refresh),
              if (state.hasStaff) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.builder(
                    itemCount: state.staff.length,
                    itemBuilder: (context, index) {
                      final employee = state.staff[index];

                      return !employee.isDismiss
                          ? EmployeeCard(
                              employee: employee,
                              refresh: _refresh,
                            )
                          : const SizedBox.shrink();
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
                      title: Text(
                        'Уволенные сотрудники',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      children: [
                        ...state.staff.map(
                          (employee) {
                            return employee.isDismiss
                                ? EmployeeCard(
                                    employee: employee,
                                    refresh: _refresh,
                                  )
                                : const SizedBox.shrink();
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
        ),
      ),
    );
  }

  ///
  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
    controller.reverseDuration = const Duration(milliseconds: 350);
  }

  ///
  void _fetchSalonEmployees() {
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      staffBloc.add(
        StaffEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
  }

  ///
  Future<void> _refresh() async {
    final block = context.read<StaffBloc>().stream.first;
    _fetchSalonEmployees();
    await block;
  }
}
