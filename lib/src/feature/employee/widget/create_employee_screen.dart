import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/widget/avatar_widget.dart';
import 'package:ln_employee/src/common/widget/field_button.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee/employee_state.dart';
import 'package:ln_employee/src/feature/employee/bloc/staff/staff_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/staff/staff_event.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/models/salon.dart';
import 'package:ln_employee/src/feature/salon/widget/salon_choice_screen.dart';
import 'package:ln_employee/src/feature/specialization/model/specialization.dart';
import 'package:ln_employee/src/feature/specialization/widget/specialization_list.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/animated_button.dart';
import 'components/date_picker_field.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/employee/model/employee_create/employee_create.dart';
import '/src/feature/employee/model/employee_create/user_create.dart';

///
class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  /// Focus nodes
  late final FocusNode _firstNameFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _addressFocusNode;
  late final FocusNode _salesFocusNode;

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

  /// Mutable variables
  int stars = 1;
  DateTime dateOfEmployment = DateTime.now();
  DateTime birthDate = DateTime.now();

  Specialization? employeeSpecialization;
  Salon? employeeSalon;

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

    /// Focus nodes
    _firstNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _salesFocusNode = FocusNode();
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
    _firstNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    _salesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedButton(
                    child: Text(
                      'Отмена',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    'Новый сотрудник',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  AnimatedButton(
                    child: Text(
                      'Готово',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _create();
                        _refresh();
                        context.pop();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList.list(
                      children: [
                        const SizedBox(height: 8),
                        Center(
                          child: Stack(
                            children: [
                              const AvatarWidget(radius: 65),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF272727),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    color: context.colorScheme.secondary,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const HeaderWidget(label: 'Рейтинг'),
                              StarRating(
                                initialRating: stars,
                                onRatingChanged: (rating) => stars = rating,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const HeaderWidget(label: 'Личная информация'),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                CustomTextField(
                                  dense: false,
                                  controller: _firstNameController,
                                  focusNode: _firstNameFocusNode,
                                  textInputAction: TextInputAction.next,
                                  label: 'Имя*',
                                  keyboardType: TextInputType.name,
                                  validator: _emptyValidator,
                                ),
                                CustomTextField(
                                  controller: _lastNameController,
                                  label: 'Фамилия*',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  validator: _emptyValidator,
                                ),
                                CustomTextField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocusNode,
                                  label: 'Телефон*',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [RuPhoneInputFormatter()],
                                  validator: _emptyValidator,
                                  onChanged: _checkPhoneNumber,
                                ),
                                CustomTextField(
                                  controller: _addressController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _addressFocusNode,
                                  label: 'Адрес проживания',
                                  keyboardType: TextInputType.streetAddress,
                                  validator: _emptyValidator,
                                ),
                                CustomTextField(
                                  controller: _emailController,
                                  label: 'Почта',
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _emailValidator,
                                ),
                                DatePickerField(
                                  controller: _birthDateController,
                                  label: 'День рождения',
                                  initialDate: birthDate,
                                  onDateSelected: (day) => birthDate = day,
                                  validator: _emptyValidator,
                                ),
                                const SizedBox(height: 32),
                                const HeaderWidget(label: 'Рабочая информация'),
                                const SizedBox(height: 16),
                                StatefulBuilder(
                                  builder: (_, setState) => FieldButton(
                                    controller: _salonController,
                                    label: 'Салон',
                                    onTap: () => ModalPopup.show(
                                      context: context,
                                      child: SalonChoiceScreen(
                                        currentSalon: employeeSalon,
                                        onChanged: (salon) => setState(() {
                                          salon != null
                                              ? employeeSalon = salon
                                              : null;
                                          _salonController.text =
                                              employeeSalon!.name;
                                        }),
                                      ),
                                    ),
                                    validator: _emptyValidator,
                                  ),
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return FieldButton(
                                      controller: _specializationController,
                                      label: 'Специализация',
                                      onTap: () => ModalPopup.show(
                                        context: context,
                                        child: SpecializationChoiceScreen(
                                          currentSpecialization:
                                              employeeSpecialization,
                                          onChanged: (specialization) =>
                                              setState(() {
                                            specialization != null
                                                ? employeeSpecialization =
                                                    specialization
                                                : null;
                                            _specializationController.text =
                                                employeeSpecialization!.name;
                                          }),
                                        ),
                                      ),
                                      validator: _emptyValidator,
                                    );
                                  },
                                ),
                                CustomTextField(
                                  controller: _descriptionController,
                                  textInputAction: TextInputAction.next,
                                  dense: false,
                                  label: 'Описание сотрудника',
                                  keyboardType: TextInputType.multiline,
                                  validator: _emptyValidator,
                                ),
                                CustomTextField(
                                  controller: _contractNumberController,
                                  textInputAction: TextInputAction.next,
                                  label: 'Номер договора',
                                  keyboardType: TextInputType.streetAddress,
                                  validator: _emptyValidator,
                                ),
                                CustomTextField(
                                  controller: _salesController,
                                  focusNode: _salesFocusNode,
                                  textInputAction: TextInputAction.done,
                                  label: 'Процент от продаж*',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  validator: _emptyValidator,
                                  onChanged: _checkSales,
                                ),
                                DatePickerField(
                                  controller: _dateOfEmploymentController,
                                  label: 'Дата принятия на работу',
                                  initialDate: dateOfEmployment,
                                  onDateSelected: (day) =>
                                      dateOfEmployment = day,
                                  validator: _emptyValidator,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16 + 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );

  ///
  Future<void> _create() async {
    context.read<EmployeeBloc>().add(
          EmployeeEvent.create(
            employee: Employee$Create(
              address: _addressController.text,
              jobId: employeeSpecialization!.id,
              salonId: employeeSalon!.id,
              description: _descriptionController.text,
              dateOfEmployment: dateOfEmployment,
              contractNumber: _contractNumberController.text,
              percentageOfSales: double.parse(_salesController.text),
              stars: stars,
              userModel: UserModel$Create(
                phone: _phoneController.text,
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                birthDate: birthDate,
              ),
            ),
          ),
        );
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

  /// Empty value validator.
  String? _emptyValidator(String? value) =>
      value!.isEmpty ? 'Обязательное поле' : null;

  /// Refresh [StaffBloc].
  Future<void> _refresh() async {
    final block = context.read<StaffBloc>().stream.first;
    final salonBloc = context.read<SalonBLoC>();
    context.read<StaffBloc>().add(
          StaffEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
        );
    await block;
  }

  ///
  void _checkPhoneNumber(String value) {
    if ((value.length == 18 && value.startsWith('+')) ||
        (value.length == 17 && value.startsWith('8'))) {
      _phoneFocusNode.unfocus();
      FocusScope.of(context).requestFocus(_addressFocusNode);
    }
  }

  ///
  void _checkSales(String value) {
    if (value.length == 3) {
      _salesFocusNode.unfocus();
    }
  }
}
