import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/widget/custom_snackbar.dart';

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
import '/src/feature/initialization/widget/dependencies_scope.dart';
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
    staffBloc = StaffBloc(
      repository: DependenciesScope.of(context).employeeRepository,
    );
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
    return BlocProvider(
      create: (context) => staffBloc,
      child: BlocListener<SalonBLoC, SalonState>(
        listener: (context, state) {},
        listenWhen: (previous, current) {
          if (previous.currentSalon?.id != current.currentSalon?.id) {
            staffBloc.add(
              StaffEvent.fetchSalonEmployees(current.currentSalon!.id),
            );
          }
          return false;
        },
        child: BlocConsumer<StaffBloc, StaffState>(
          listener: (context, state) => state.hasError
              ? CustomSnackBar.showError(context, message: state.error)
              : null,
          builder: (context, state) {
            final staff =
                state.staff.where((employee) => !employee.isDismiss).toList();
            final dismissedStaff =
                state.staff.where((employee) => employee.isDismiss).toList();
            return Scaffold(
              body: RefreshIndicator.adaptive(
                onRefresh: _onRefresh,
                edgeOffset: MediaQuery.sizeOf(context).width * 0.4,
                child: CustomScrollView(
                  slivers: [
                    CustomSliverAppBar(
                      title: context.stringOf().employees,
                      actions: [
                        AnimatedButton(
                          padding: const EdgeInsets.only(right: 16, top: 2),
                          child: Icon(
                            Icons.person_add,
                            color: context.colorScheme.secondary,
                          ),
                          onPressed: () => ModalPopup.show(
                            context: context,
                            showDivider: false,
                            transitionAnimationController: controller,
                            mobilePadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: CreateEmployeeScreen(staffBloc: staffBloc),
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
                    if (state.hasStaff) ...[
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList.separated(
                          itemCount: staff.length,
                          itemBuilder: (context, index) {
                            final employee = staff[index];

                            return EmployeeCard(
                              employee: employee,
                              refresh: _onRefresh,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                        ),
                      ),
                      if (dismissedStaff.isNotEmpty) ...[
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverToBoxAdapter(
                            child: ExpansionTile(
                              title: Text(
                                'Уволенные сотрудники',
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                              children: [
                                ...dismissedStaff.map(
                                  (employee) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: EmployeeCard(
                                      employee: employee,
                                      refresh: _onRefresh,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height / 8,
                        ),
                      )
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
            );
          },
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
  Future<void> _onRefresh() async {
    final block = staffBloc.stream.first;
    _fetchSalonEmployees();
    await block;
  }
}
