import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_employee/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/common/widget/field_button.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_state.dart';
import 'package:ln_employee/src/feature/employee/bloc/staff/staff_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/staff/staff_event.dart';
import 'package:ln_employee/src/feature/employee/widget/components/copy_icon.dart';
import 'package:ln_employee/src/feature/salon/models/salon.dart';
import 'package:ln_employee/src/feature/salon/widget/salon_choice_screen.dart';
import 'package:ln_employee/src/feature/specialization/model/specialization.dart';
import 'package:ln_employee/src/feature/specialization/widget/specialization_list.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/overlay/message_popup.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';
import '/src/feature/employee/model/employee_edit/user_edit.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import 'components/date_picker_field.dart';
import 'components/expanded_app_bar.dart';
import 'components/skeleton_employee_screen.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EditEmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EditEmployeeScreen({super.key, required this.id});

  /// Employee id.
  final int id;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  ///
  final _formKey = GlobalKey<FormState>();

  ///
  late final _phoneFocusNode = FocusNode();

  /// User information
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;

  /// Employee information
  late final TextEditingController _salonController;
  late final TextEditingController _specializationController;
  late final TextEditingController _contractNumberController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _salesController;
  late final TextEditingController _dateOfEmploymentController;

  @override
  void initState() {
    super.initState();

    context.read<EmployeeBloc>().add(EmployeeEvent.fetch(id: widget.id));

    /// User information.
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _birthDateController = TextEditingController();

    /// Employee information.
    _salonController = TextEditingController();
    _specializationController = TextEditingController();
    _contractNumberController = TextEditingController();
    _descriptionController = TextEditingController();
    _salesController = TextEditingController();
    _dateOfEmploymentController = TextEditingController();
  }

  @override
  void dispose() {
    /// User information
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();

    /// Employee information
    _salonController.dispose();
    _specializationController.dispose();
    _contractNumberController.dispose();
    _descriptionController.dispose();
    _salesController.dispose();
    _dateOfEmploymentController.dispose();

    /// Focus nodes
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.colorScheme.background,
        body: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: state.employee == null ? 0 : 1,
          child: state.employee == null
              ? const SkeletonEditEmployeeScreen()
              : Builder(
                  builder: (context) {
                    final employee = state.employee!;
                    final user = state.employee!.userModel;
                    final dismissed = state.employee!.isDismiss;

                    int stars = employee.stars;
                    DateTime birthDate = user.birthDate;
                    DateTime dateOfEmployment = employee.dateOfEmployment;
                    Salon employeeSalon = employee.salon;
                    Specialization employeeSpecialization = employee.jobModel;

                    /// User information
                    _firstNameController.text = user.firstName;
                    _lastNameController.text = user.lastName;
                    _phoneController.text = user.phone;
                    _addressController.text = employee.address;
                    _emailController.text = user.email;
                    _birthDateController.text = birthDate.defaultFormat();

                    /// Employee information
                    _salonController.text = employeeSalon.name;
                    _specializationController.text =
                        employeeSpecialization.name;
                    _contractNumberController.text = employee.contractNumber;
                    _descriptionController.text = employee.description;
                    _salesController.text =
                        employee.percentageOfSales.toString();
                    _dateOfEmploymentController.text =
                        dateOfEmployment.defaultFormat();
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
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: context.colorScheme.primary,
                                side:
                                    const BorderSide(color: Color(0xFF272727)),
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
                                  dismissed || state.isSuccessful
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            onRatingChanged: (rating) =>
                                                stars = rating,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      DefaultTextStyle(
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
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
                                          label: 'Личная информация'),
                                      const SizedBox(height: 14),
                                      CustomTextField(
                                        controller: _firstNameController,
                                        dense: false,
                                        label: 'Имя',
                                        keyboardType: TextInputType.name,
                                        validator: _emptyValidator,
                                      ),
                                      CustomTextField(
                                        controller: _lastNameController,
                                        label: 'Фамилия',
                                        keyboardType: TextInputType.name,
                                        validator: _emptyValidator,
                                      ),
                                      CustomTextField(
                                        controller: _phoneController,
                                        label: 'Номер телефона',
                                        focusNode: _phoneFocusNode,
                                        onChanged: _checkPhoneNumber,
                                        inputFormatters: [
                                          RuPhoneInputFormatter()
                                        ],
                                        keyboardType: TextInputType.phone,
                                        validator: _emptyValidator,
                                        suffix: CopyIcon(_phoneController.text),
                                      ),
                                      CustomTextField(
                                        controller: _addressController,
                                        label: 'Домашний адрес',
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: _emptyValidator,
                                      ),
                                      CustomTextField(
                                        controller: _emailController,
                                        label: 'Электронная почта',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: _emailValidator,
                                        suffix: CopyIcon(_emailController.text),
                                      ),
                                      DatePickerField(
                                        controller: _birthDateController,
                                        label: 'День рождения',
                                        initialDate: birthDate,
                                        onDateSelected: (day) =>
                                            birthDate = day,
                                        validator: _emptyValidator,
                                      ),
                                      const SizedBox(height: 32),
                                      const HeaderWidget(
                                          label: 'Рабочая информация'),
                                      const SizedBox(height: 8),
                                      // TODO(zhorenty): refactor
                                      StatefulBuilder(
                                        builder: (_, setState) => FieldButton(
                                          controller: _salonController,
                                          label: 'Салон',
                                          onTap: () => ModalPopup.show(
                                            context: context,
                                            child: SalonChoiceScreen(
                                              currentSalon: employeeSalon,
                                              onChanged: (salon) =>
                                                  setState(() {
                                                salon != null
                                                    ? employeeSalon = salon
                                                    : null;
                                                _salonController.text =
                                                    employeeSalon.name;
                                              }),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // TODO(zhorenty): refactor
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          return FieldButton(
                                            controller:
                                                _specializationController,
                                            label: 'Специализация',
                                            onTap: () => ModalPopup.show(
                                              context: context,
                                              child: SpecializationChoiceScreen(
                                                currentSpecialization:
                                                    employeeSpecialization,
                                                onChanged: (specialization) =>
                                                    setState(
                                                  () {
                                                    specialization != null
                                                        ? employeeSpecialization =
                                                            specialization
                                                        : null;
                                                    _specializationController
                                                            .text =
                                                        employeeSpecialization
                                                            .name;
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      CustomTextField(
                                        controller: _contractNumberController,
                                        label: 'Номер договора',
                                        validator: _emptyValidator,
                                      ),
                                      CustomTextField(
                                        controller: _descriptionController,
                                        label: 'Описание сотрудника',
                                        keyboardType: TextInputType.multiline,
                                        validator: _emptyValidator,
                                      ),
                                      CustomTextField(
                                        controller: _salesController,
                                        label: 'Процент от продаж',
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          decimal: true,
                                        ),
                                        validator: _emptyValidator,
                                      ),
                                      DatePickerField(
                                        controller: _dateOfEmploymentController,
                                        label: 'Дата принятия на работу',
                                        initialDate: dateOfEmployment,
                                        onDateSelected: (day) =>
                                            dateOfEmployment = day,
                                        validator: _emptyValidator,
                                      ),
                                      const SizedBox(height: 16),
                                      Center(
                                        child: AnimatedButton(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _edit(
                                                  id: employee.id,
                                                  employeeSalonId:
                                                      employeeSalon.id,
                                                  specializationId:
                                                      employeeSpecialization.id,
                                                  stars: stars,
                                                  isDismiss: employee.isDismiss,
                                                  dateOfEmployment:
                                                      dateOfEmployment,
                                                  birthDate: birthDate,
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        8,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              backgroundColor:
                                                  context.colorScheme.primary,
                                            ),
                                            child: Text(
                                              'Сохранить изменения',
                                              style: context.textTheme.bodyLarge
                                                  ?.copyWith(
                                                color: context
                                                    .colorScheme.onBackground,
                                                fontFamily:
                                                    FontFamily.geologica,
                                              ),
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
                    );
                  },
                ),
        ),
      ),
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
              address: _addressController.text,
              jobId: specializationId,
              salonId: employeeSalonId,
              description: _descriptionController.text,
              dateOfEmployment: dateOfEmployment,
              contractNumber: _contractNumberController.text,
              percentageOfSales: double.parse(_salesController.text),
              stars: stars,
              isDismiss: isDismiss,
              userModel: UserModel$Edit(
                email: _emailController.text,
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                phone: _phoneController.text,
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
      _phoneFocusNode.unfocus();
    }
  }

  /// Empty value validator.
  String? _emptyValidator(String? value) =>
      value!.isEmpty ? 'Обязательное поле' : null;

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
