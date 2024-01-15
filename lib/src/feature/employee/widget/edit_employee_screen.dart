import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/widget/custom_snackbar.dart';
import 'package:ln_employee/src/common/widget/star_rating.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/field_button.dart';
import '/src/common/widget/overlay/modal_popup.dart';
import '/src/feature/employee/bloc/employee/employee_bloc.dart';
import '/src/feature/employee/bloc/employee/employee_event.dart';
import '/src/feature/employee/bloc/employee/employee_state.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';
import '/src/feature/employee/model/employee_edit/user_edit.dart';
import '/src/feature/salon/models/salon.dart';
import '/src/feature/salon/widget/salon_choice_screen.dart';
import '/src/feature/specialization/model/specialization.dart';
import '/src/feature/specialization/widget/specialization_list.dart';
import 'components/copy_icon.dart';
import 'components/date_picker_field.dart';

/// {@template employee_edit_screen}
/// Employee edit screen.
/// {@endtemplate}
class EditEmployeeScreen extends StatefulWidget {
  /// {@macro employee_edit_screen}
  const EditEmployeeScreen({super.key, required this.id});

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
  Widget build(BuildContext context) =>
      BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) => state.hasError
            ? CustomSnackBar.showError(context, message: state.error)
            : null,
        builder: (context, state) {
          final employee = state.employee!;
          final user = state.employee!.userModel;

          DateTime birthDate = user.birthDate;
          DateTime? dateOfEmployment = employee.dateOfEmployment;
          Salon employeeSalon = employee.salon;
          Specialization employeeSpecialization = employee.jobModel;
          int stars = employee.stars;

          /// User information
          _firstNameController.text = user.firstName;
          _lastNameController.text = user.lastName;
          _phoneController.text = user.phone;
          if (employee.address != null) {
            _addressController.text = employee.address!;
          }
          _emailController.text = user.email;
          _birthDateController.text = birthDate.defaultFormat();

          /// Employee information
          _salonController.text = employeeSalon.name;
          _specializationController.text = employeeSpecialization.name;
          if (employee.contractNumber != null) {
            _contractNumberController.text = employee.contractNumber!;
          }
          if (employee.description != null) {
            _descriptionController.text = employee.description!;
          }
          _salesController.text = employee.percentageOfSales.toString();
          if (dateOfEmployment != null) {
            _dateOfEmploymentController.text = dateOfEmployment.defaultFormat();
          }

          return Scaffold(
            backgroundColor: context.colorScheme.onBackground,
            body: Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      'Редактирование',
                      style: context.textTheme.titleLarge!.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    sliver: SliverList.list(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Рейтинг',
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontSize: 25,
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            StarRating(
                              initialRating: employee.stars,
                              onRatingChanged: (rating) => stars = rating,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Личная информация',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 25,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
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
                          inputFormatters: [RuPhoneInputFormatter()],
                          keyboardType: TextInputType.phone,
                          validator: _emptyValidator,
                          suffix: CopyIcon(_phoneController.text),
                        ),
                        CustomTextField(
                          controller: _addressController,
                          label: 'Домашний адрес',
                          keyboardType: TextInputType.streetAddress,
                          validator: _emptyValidator,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          label: 'Электронная почта',
                          keyboardType: TextInputType.emailAddress,
                          validator: _emailValidator,
                          suffix: CopyIcon(_emailController.text),
                        ),
                        DatePickerField(
                          controller: _birthDateController,
                          label: 'День рождения',
                          initialDate: birthDate,
                          onDateSelected: (day) => birthDate = day,
                          validator: _emptyValidator,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Рабочая информация',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 25,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
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
                                onChanged: (salon) => setState(() {
                                  salon != null ? employeeSalon = salon : null;
                                  _salonController.text = employeeSalon.name;
                                }),
                              ),
                            ),
                          ),
                        ),
                        // TODO(zhorenty): refactor
                        StatefulBuilder(
                          builder: (context, setState) => FieldButton(
                            controller: _specializationController,
                            label: 'Специализация',
                            onTap: () => ModalPopup.show(
                              context: context,
                              child: SpecializationChoiceScreen(
                                currentSpecialization: employeeSpecialization,
                                onChanged: (specialization) => setState(
                                  () {
                                    specialization != null
                                        ? employeeSpecialization =
                                            specialization
                                        : null;
                                    _specializationController.text =
                                        employeeSpecialization.name;
                                  },
                                ),
                              ),
                            ),
                          ),
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
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          validator: _emptyValidator,
                        ),
                        if (dateOfEmployment != null)
                          DatePickerField(
                            controller: _dateOfEmploymentController,
                            label: 'Дата принятия на работу',
                            initialDate: dateOfEmployment,
                            onDateSelected: (day) => dateOfEmployment = day,
                            validator: _emptyValidator,
                          ),
                        const SizedBox(height: 16),
                        Center(
                          child: AnimatedButton(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _edit(
                                    id: employee.id,
                                    employeeSalonId: employeeSalon.id,
                                    specializationId: employeeSpecialization.id,
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
                                backgroundColor: context.colorScheme.primary,
                              ),
                              child: Text(
                                'Сохранить изменения',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colorScheme.onBackground,
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  /// Dismiss employee by [id].
  Future<void> _edit({
    required int id,
    required DateTime? dateOfEmployment,
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
    context.pop();
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
}
