import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/custom_date_picker.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/overlay/message_popup.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/edit_employee/bloc/employee_bloc.dart';
import '/src/feature/edit_employee/bloc/employee_event.dart';
import '/src/feature/edit_employee/bloc/employee_state.dart';
import '/src/feature/staff/bloc/staff_bloc.dart';
import '/src/feature/staff/bloc/staff_event.dart';
import '/src/feature/staff/model/employee.dart';
import '../../staff/model/job.dart';
import '/src/feature/staff/model/salon.dart';
import '/src/feature/staff/model/user.dart';

import 'components/expanded_app_bar.dart';
import 'skeleton_employee_screen.dart';

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

  late final phoneFocusNode = FocusNode();

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
                    EmployeeEvent.edit(
                      employee: EmployeeModel(
                        id: employee.id,
                        address: addressController.text,
                        jobId: 1,
                        salonId: 1,
                        description: descriptonController.text,
                        dateOfEmployment: dateOfEmployment,
                        contractNumber: contractNumberController.text,
                        percentageOfSales: double.parse(salesController.text),
                        stars: stars,
                        isDismiss: employee.isDismiss,
                        userModel: UserModel(
                          id: employee.userModel.id,
                          password: employee.userModel.password,
                          email: emailController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                          birthDate: birthDate,
                          isSuperuser: employee.userModel.isSuperuser,
                          isActive: employee.userModel.isActive,
                        ),
                        jobModel: JobModel(
                          id: employee.jobModel.id,
                          name: employee.jobModel.name,
                          oklad: employee.jobModel.oklad,
                        ),
                        salonModel: SalonModel(
                          id: employee.salonModel.id,
                          address: employee.salonModel.address,
                          phone: employee.salonModel.phone,
                          email: employee.salonModel.email,
                          description: employee.salonModel.description,
                        ),
                      ),
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
                  label: '${user.firstName} ${user.lastName}',
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
                          dissmised || state.isSuccessful
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
                  onExit: () {
                    _refreshStaff();
                    context.pop();
                  },
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
                                const HeaderWidget(
                                  label: 'Рейтинг',
                                  showUnderscore: false,
                                ),
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
                                  const HeaderWidget(
                                    label: 'Статус сотрудника',
                                    showUnderscore: false,
                                  ),
                                  dissmised
                                      ? const Text('Уволен')
                                      : const Text('Работает')
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const HeaderWidget(label: 'Личная информация'),
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
                              focusNode: phoneFocusNode,
                              onChanged: _checkPhoneNumber,
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
                            const HeaderWidget(label: 'Рабочая информация'),
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

  ///
  void _checkPhoneNumber(String value) {
    if ((value.length == 18 && value.startsWith('+')) ||
        (value.length == 17 && value.startsWith('8'))) {
      phoneFocusNode.unfocus();
    }
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
    context.read<StaffBloc>().add(const StaffEvent.fetch());
    await block;
  }
}
