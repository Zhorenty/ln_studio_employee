import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/widget/field_button.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/salon/models/salon.dart';
import 'package:ln_employee/src/feature/salon/widget/salon_choice_screen.dart';
import 'package:ln_employee/src/feature/specialization/model/specialization.dart';
import 'package:ln_employee/src/feature/specialization/widget/specialization_list.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/custom_date_picker.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/overlay/message_popup.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/employee/bloc/employee_bloc.dart';
import '/src/feature/employee/bloc/employee_event.dart';
import '/src/feature/employee/bloc/employee_state.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';
import '/src/feature/employee/model/employee_edit/user_edit.dart';
import '/src/feature/employee_all/bloc/staff_bloc.dart';
import '/src/feature/employee_all/bloc/staff_event.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';

import 'components/expanded_app_bar.dart';
import 'skeleton_employee_screen.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EmployeeScreen({super.key, required this.employeeId});

  /// Employee id.
  final int employeeId;

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  late final phoneFocusNode = FocusNode();

  /// User information
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController emailController;

  /// Employee information
  late final TextEditingController contractNumberController;
  late final TextEditingController descriptionController;
  late final TextEditingController salesController;

  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(
          EmployeeEvent.fetch(id: widget.employeeId),
        );

    /// User information.
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();

    /// Employee information.
    contractNumberController = TextEditingController();
    descriptionController = TextEditingController();
    salesController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    contractNumberController.dispose();
    descriptionController.dispose();
    salesController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

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
          Salon employeeSalon = employee.salon;
          Specialization employeeSpecialization = employee.jobModel;

          /// User information
          firstNameController.text = user.firstName;
          lastNameController.text = user.lastName;
          phoneController.text = user.phone;
          addressController.text = employee.address;
          emailController.text = user.email;

          /// Employee information
          contractNumberController.text = employee.contractNumber;
          descriptionController.text = employee.description;
          salesController.text = employee.percentageOfSales.toString();

          return Scaffold(
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
                    employee.clients.toString(),
                    style: context.textTheme.titleLarge!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  trailing: Text(
                    employee.workedDays.toString(),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                validator: _emptyValidator,
                              ),
                              CustomTextField(
                                controller: lastNameController,
                                label: 'Фамилия',
                                keyboardType: TextInputType.name,
                                validator: _emptyValidator,
                              ),
                              CustomTextField(
                                controller: phoneController,
                                label: 'Номер телефона',
                                focusNode: phoneFocusNode,
                                onChanged: _checkPhoneNumber,
                                inputFormatters: [RuPhoneInputFormatter()],
                                keyboardType: TextInputType.phone,
                                validator: _emptyValidator,
                                copyable: true,
                              ),
                              CustomTextField(
                                controller: addressController,
                                label: 'Домашний адрес',
                                keyboardType: TextInputType.streetAddress,
                                validator: _emptyValidator,
                              ),
                              CustomTextField(
                                controller: emailController,
                                label: 'Электронная почта',
                                copyable: true,
                                keyboardType: TextInputType.emailAddress,
                                validator: _emailValidator,
                              ),
                              DatePickerButton(
                                label: 'День рождения',
                                initialDate: birthDate,
                                onDateSelected: (day) => birthDate = day,
                              ),
                              const SizedBox(height: 32),
                              const HeaderWidget(label: 'Рабочая информация'),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return FieldButton(
                                    dense: false,
                                    label: 'Салон',
                                    title: employeeSalon.name,
                                    onTap: () => ModalPopup.show(
                                      context: context,
                                      child: SalonChoiceScreen(
                                        currentSalon: employeeSalon,
                                        onChanged: (salon) {
                                          setState(() {
                                            if (salon != null) {
                                              employeeSalon = salon;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return FieldButton(
                                    dense: false,
                                    label: 'Специализация',
                                    title: employeeSpecialization.name,
                                    onTap: () => ModalPopup.show(
                                      context: context,
                                      child: SpecializationChoiceScreen(
                                        currentSpecialization:
                                            employeeSpecialization,
                                        onChanged: (specialization) {
                                          setState(() {
                                            if (specialization != null) {
                                              employeeSpecialization =
                                                  specialization;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              CustomTextField(
                                controller: contractNumberController,
                                label: 'Номер договора',
                                validator: _emptyValidator,
                              ),
                              CustomTextField(
                                controller: descriptionController,
                                label: 'Описание сотрудника',
                                keyboardType: TextInputType.multiline,
                                validator: _emptyValidator,
                              ),
                              CustomTextField(
                                controller: salesController,
                                label: 'Процент от продаж',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                validator: _emptyValidator,
                              ),
                              DatePickerButton(
                                dense: true,
                                label: 'Дата принятия на работу',
                                initialDate: dateOfEmployment,
                                onDateSelected: (day) => dateOfEmployment = day,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _edit(
                                        id: employee.id,
                                        employeeSalonId: employeeSalon.id,
                                        specializationId:
                                            employeeSpecialization.id,
                                        stars: stars,
                                        isDismiss: employee.isDismiss,
                                        dateOfEmployment: dateOfEmployment,
                                        birthDate: birthDate,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal:
                                          MediaQuery.sizeOf(context).width / 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor:
                                        context.colorScheme.primary,
                                  ),
                                  child: Text(
                                    'Сохранить изменения',
                                    style:
                                        context.textTheme.bodyLarge?.copyWith(
                                      color: context.colorScheme.onBackground,
                                      fontFamily: FontFamily.geologica,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
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
  Future<void> _edit({
    required int id,
    required DateTime dateOfEmployment,
    required int stars,
    required bool isDismiss,
    required DateTime birthDate,
    required int employeeSalonId,
    required int specializationId,
  }) async {
    context.read<EmployeeBloc>().add(
          EmployeeEvent.edit(
            employee: Employee$Edit(
              id: id,
              address: addressController.text,
              jobId: specializationId,
              salonId: employeeSalonId,
              description: descriptionController.text,
              dateOfEmployment: dateOfEmployment,
              contractNumber: contractNumberController.text,
              percentageOfSales: double.parse(salesController.text),
              stars: stars,
              isDismiss: isDismiss,
              userModel: UserModel$Edit(
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneController.text,
                birthDate: birthDate,
              ),
            ),
          ),
        );
  }

  /// Phone number FocusNode condition.
  void _checkPhoneNumber(String value) {
    if ((value.length == 18 && value.startsWith('+')) ||
        (value.length == 17 && value.startsWith('8'))) {
      phoneFocusNode.unfocus();
    }
  }

  /// Empty value validator.
  String? _emptyValidator(String? value) {
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else {
      return null;
    }
  }

  /// Validate email address.
  String? _emailValidator(String? value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Введите корректный e-mail';
    } else {
      return null;
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
