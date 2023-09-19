import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/custom_date_picker.dart';
import '/src/common/widget/overlay/message_popup.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/employee/bloc/employee_bloc.dart';
import '/src/feature/employee/bloc/employee_event.dart';
import '/src/feature/employee/bloc/employee_state.dart';
import '/src/feature/employee/widget/skeleton_employee_screen.dart';
import '/src/feature/staff/bloc/staff_bloc.dart';
import '/src/feature/staff/bloc/staff_event.dart';

import 'components/custom_text_field.dart';
import 'components/expanded_app_bar.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EmployeeScreen({super.key, required this.employeeid});

  /// Employee id.
  final int employeeid;

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(
          EmployeeEvent.fetch(id: widget.employeeid),
        );
  }

  /// User information
  late final firstNameController = TextEditingController();
  late final lastNameController = TextEditingController();
  late final phoneController = TextEditingController();
  late final addressController = TextEditingController();

  /// Employee information
  late final contractNumberController = TextEditingController();
  late final starsController = TextEditingController();
  // TODO(zhorenty): Make huge TextField.
  late final descriptonController = TextEditingController();
  late final emailController = TextEditingController();
  // TODO(zhorenty): Make DropDownButton or something.
  late final salesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state.employee == null) {
          return const SkeletonEmployeeScreen();
        } else {
          final employee = state.employee!;
          final user = state.employee!.userModel;
          final dissmised = state.employee!.isDismiss;

          int stars = employee.stars;
          DateTime birthDate = user.birthDate;
          DateTime dateOfEmployment = employee.dateOfEmployment;

          /// User information
          firstNameController.text = user.firstName;
          lastNameController.text = user.lastName;
          phoneController.text = user.phone;
          addressController.text = employee.address;
          emailController.text = user.email;

          /// Employee information
          contractNumberController.text = employee.contractNumber;
          descriptonController.text = employee.description;
          salesController.text = employee.percentageOfSales.toString();

          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => context.read<EmployeeBloc>().add(
                    EmployeeEvent.editEmployee(
                      // Id of employee
                      id: employee.id,

                      // User information
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      email: emailController.text,
                      birthDate: birthDate,

                      /// Employee information
                      contractNumber: contractNumberController.text,
                      stars: stars,
                      description: descriptonController.text,
                      percentageOfSales: double.parse(salesController.text),
                      dateOfEmployment: dateOfEmployment,
                    ),
                  ),
              label: Text(
                'Сохранить изменения',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorScheme.onBackground,
                ),
              ),
              backgroundColor: context.colorScheme.primary,
            ),
            backgroundColor: context.colorScheme.background,
            body: CustomScrollView(
              slivers: [
                ExpandedAppBar(
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: context.textTheme.titleLarge!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  leading: Text(
                    // TODO(zhorenty): Fetch from repository.
                    '24',
                    style: context.textTheme.titleLarge!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  trailing: Text(
                    // TODO(zhorenty): Fetch from repository.
                    '126',
                    style: context.textTheme.titleLarge!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  additionalTrailing: [
                    ElevatedButton(
                      onPressed: () {
                        dissmised
                            ? _reinstatement(employee.id)
                            : _dismiss(employee.id);
                        context.pop();
                        MessagePopup.success(
                          context,
                          dissmised
                              ? 'Вы вернули сотрудника на должность'
                              : 'Сотрудник успешно уволен',
                        );
                      },
                      child: Text(
                        dissmised
                            ? 'Восстановить сотрудника в должности'
                            : 'Уволить сотрудника',
                      ),
                    ),
                  ],
                  onExit: () => _refreshStaff().then((_) => context.pop()),
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: () => _fetch(employee.id),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.colorScheme.onBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const _Header(label: 'Рейтинг'),
                                StarRating(
                                  initialRating: employee.stars,
                                  onRatingChanged: (rating) => stars = rating,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            DefaultTextStyle(
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontFamily: FontFamily.geologica,
                                color: dissmised
                                    ? const Color(0xFFF45636)
                                    : context.colorScheme.primary,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const _Header(label: 'Статус сотрудника'),
                                  dissmised
                                      ? const Text('Уволен')
                                      : const Text('Работает')
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const _Header(label: 'Личная информация'),
                            const _UnderscoreWidget(),
                            CustomTextField(
                              controller: firstNameController,
                              dense: false,
                              label: 'Имя',
                              keyboardType: TextInputType.name,
                            ),
                            CustomTextField(
                              controller: lastNameController,
                              label: 'Фамилия',
                              keyboardType: TextInputType.name,
                            ),
                            CustomTextField(
                              controller: phoneController,
                              label: 'Номер телефона',
                              inputFormatters: [RuPhoneInputFormatter()],
                              keyboardType: TextInputType.phone,
                              copyable: true,
                            ),
                            CustomTextField(
                              controller: addressController,
                              label: 'Домашний адрес',
                              keyboardType: TextInputType.streetAddress,
                            ),
                            CustomTextField(
                              controller: emailController,
                              label: 'Электронная почта',
                              copyable: true,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            DatePickerButton(
                              initialDate: birthDate,
                              onDateSelected: (day) => birthDate = day,
                            ),
                            const SizedBox(height: 32),
                            const _Header(label: 'Рабочая информация'),
                            const _UnderscoreWidget(),
                            CustomTextField(
                              controller: contractNumberController,
                              label: 'Номер договора',
                            ),
                            CustomTextField(
                              controller: descriptonController,
                              label: 'Описание сотрудника',
                              keyboardType: TextInputType.multiline,
                            ),
                            CustomTextField(
                              controller: salesController,
                              label: 'Процент от продаж',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                            ),
                            DatePickerButton(
                              initialDate: dateOfEmployment,
                              onDateSelected: (day) => dateOfEmployment = day,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  /// Dismiss employee by [id].
  Future<void> _dismiss(int id) async {
    context.read<EmployeeBloc>().add(EmployeeEvent.dismiss(id: id));
  }

  /// Dismiss employee by [id].
  Future<void> _reinstatement(int id) async {
    context.read<EmployeeBloc>().add(EmployeeEvent.reinstatement(id: id));
  }

  /// Fetch employee by [id].
  Future<void> _fetch(int id) async {
    context.read<EmployeeBloc>().add(EmployeeEvent.fetch(id: id));
  }

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

/// Horizontal line.
///
/// Usually used for underscores.
class _UnderscoreWidget extends StatelessWidget {
  const _UnderscoreWidget();

  @override
  Widget build(BuildContext context) => Container(
        height: 3,
        width: 50,
        decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
      );
}

/// Header widget with provided [label].
class _Header extends StatelessWidget {
  const _Header({required this.label});

  /// Label of this [_Header].
  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
      );
}
