import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/assets.gen.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/field_button.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/overlay/message_popup.dart';
import '/src/feature/employee/bloc/employee/employee_bloc.dart';
import '/src/feature/employee/bloc/employee/employee_event.dart';
import '/src/feature/employee/bloc/employee/employee_state.dart';
import '/src/feature/employee/bloc/staff/staff_bloc.dart';
import '/src/feature/employee/bloc/staff/staff_event.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import 'components/expanded_app_bar.dart';
import 'components/skeleton_employee_screen.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EmployeeScreen({super.key, required this.id});

  /// Employee id.
  final int id;

  @override
  State<EmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EmployeeScreen> {
  // Переменные, которые не должны изменяться при rebuild'е.
  int? clientsCount;
  int? workedDaysCount;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) => Scaffold(
          body: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: state.employee == null ? 0 : 1,
            child: state.employee == null
                ? const SkeletonEmployeeScreen()
                : Builder(
                    builder: (context) {
                      final employee = state.employee!;
                      final user = state.employee!.userModel;
                      final dismissed = state.employee!.isDismiss;

                      if (clientsCount == null) {
                        clientsCount = employee.clients;
                        workedDaysCount = employee.workedDays;
                      }

                      return CustomScrollView(
                        slivers: [
                          ExpandedAppBar(
                            label: user.fullName,
                            title: Text(
                              user.fullName,
                              style: context.textTheme.titleLarge!.copyWith(
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            leading: Text(
                              clientsCount.toString(),
                              style: context.textTheme.titleLarge!.copyWith(
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            trailing: Text(
                              workedDaysCount.toString(),
                              style: context.textTheme.titleLarge!.copyWith(
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            additionalTrailing: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  backgroundColor: context.colorScheme.primary,
                                  side: const BorderSide(
                                    color: Color(0xFF272727),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  dismissed
                                      ? _reinstatement(employee.id)
                                      : _dismiss(employee.id);
                                  context.pop();
                                  MessagePopup.success(
                                    context,
                                    dismissed
                                        ? 'Вы вернули сотрудника на должность'
                                        : 'Сотрудник успешно уволен',
                                  );
                                },
                                child: Text(
                                  dismissed
                                      ? 'Восстановить сотрудника в должности'
                                      : 'Уволить сотрудника',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onBackground,
                                    fontFamily: FontFamily.geologica,
                                  ),
                                ),
                              ),
                            ],
                            onExit: () {
                              context.pop();
                              _refreshStaff();
                            },
                          ),
                          CupertinoSliverRefreshControl(
                            onRefresh: () => _fetch(employee.id),
                          ),
                          SliverList.list(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.onBackground,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefaultTextStyle(
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        color: dismissed
                                            ? const Color(0xFFF45636)
                                            : context.colorScheme.primary,
                                        fontFamily: FontFamily.geologica,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const HeaderWidget(
                                            label: 'Статус сотрудника',
                                            showUnderscore: false,
                                          ),
                                          dismissed
                                              ? const Text('Уволен')
                                              : const Text('Работает')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const HeaderWidget(
                                      label: 'Портфолио',
                                      showUnderscore: false,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 110,
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.background,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0xFF272727),
                                        ),
                                      ),
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          PortfolioContainer(
                                            child: Center(
                                              child: Icon(
                                                Icons.add_circle_rounded,
                                                size: 50,
                                                color: context.colorScheme
                                                    .primaryContainer,
                                              ),
                                            ),
                                          ),
                                          PortfolioContainer(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Assets.images.logoBlack
                                                  .image(fit: BoxFit.cover),
                                            ),
                                          ),
                                          const PortfolioContainer(),
                                          const PortfolioContainer(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    FieldButton(
                                      label: 'Редактировать',
                                      onTap: () => context.goNamed(
                                        'employee_edit',
                                      ),
                                      controller: TextEditingController(),
                                    ),
                                    FieldButton(
                                      controller: TextEditingController(),
                                      label: 'График работы',
                                      onTap: () => context.goNamed(
                                        'employee_timetable',
                                        pathParameters: {
                                          'id': employee.id.toString(),
                                          'salonId': context
                                              .read<SalonBLoC>()
                                              .state
                                              .currentSalon!
                                              .id
                                              .toString()
                                        },
                                      ),
                                    ),
                                    FieldButton(
                                      controller: TextEditingController(),
                                      label: 'Клиенты',
                                      onTap: () {},
                                    ),
                                    FieldButton(
                                      controller: TextEditingController(),
                                      label: 'Услуги',
                                      onTap: () {},
                                    ),
                                    FieldButton(
                                      controller: TextEditingController(),
                                      label: 'Написать сотруднику',
                                      onTap: () {},
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
      );

  /// Dismiss employee by [id].
  Future<void> _dismiss(int id) async =>
      context.read<EmployeeBloc>().add(EmployeeEvent.dismiss(id: id));

  /// Dismiss employee by [id].
  void _reinstatement(int id) =>
      context.read<EmployeeBloc>().add(EmployeeEvent.reinstatement(id: id));

  /// Fetch employee by [id].
  Future<void> _fetch(int id) async =>
      context.read<EmployeeBloc>().add(EmployeeEvent.fetch(id: id));

  /// Refresh all employee's.
  Future<void> _refreshStaff() async {
    final block = context.read<StaffBloc>().stream.first;
    final salonBloc = context.read<SalonBLoC>();
    final staffBloc = context.read<StaffBloc>();
    if (salonBloc.state.currentSalon != null) {
      staffBloc.add(
        StaffEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
    await block;
  }
}

///
class PortfolioContainer extends StatelessWidget {
  const PortfolioContainer({super.key, this.child});

  ///
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF272727),
        ),
      ),
      child: child,
    );
  }
}
