import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_date_picker.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/create_employee/model/employee_create.dart';
import '/src/feature/create_employee/model/user_create.dart';
import '/src/feature/employee/bloc/employee_bloc.dart';
import '/src/feature/employee/bloc/employee_event.dart';
import '/src/feature/employee/bloc/employee_state.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  late final FocusNode firstNameFocusNode = FocusNode();
  late final FocusNode phoneFocusNode = FocusNode();
  late final FocusNode addressFocusNode = FocusNode();
  late final FocusNode salesFocusNode = FocusNode();

  /// User information
  late final firstNameController = TextEditingController();
  late final lastNameController = TextEditingController();
  late final phoneController = TextEditingController();
  late final addressController = TextEditingController();

  /// Employee information
  late final contractNumberController = TextEditingController();

  late final starsController = TextEditingController();
  // TODO(zhorenty): Make huge TextField.
  late final descriptionController = TextEditingController();
  late final emailController = TextEditingController();
  // TODO(zhorenty): Make DropDownButton or something.
  late final salesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    int stars = 3;
    DateTime dateOfEmployment = DateTime.now();
    DateTime birthDate = DateTime.now();

    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colorScheme.scrim,
          // resizeToAvoidBottomInset: true,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: MediaQuery.sizeOf(context).height / 1.189,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedButton(
                      child: const Text('Отмена'),
                      onPressed: () => context.pop(),
                    ),
                    Text(
                      'Новый сотрудник',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    AnimatedButton(
                      child: const Text('Готово'),
                      // Implement bloc here.
                      onPressed: () {
                        context.read<EmployeeBloc>().add(
                              EmployeeEvent.create(
                                employee: EmployeeModel$Create(
                                  address: addressController.text,
                                  jobId: 1,
                                  salonId: 1,
                                  description: descriptionController.text,
                                  dateOfEmployment: dateOfEmployment,
                                  contractNumber: contractNumberController.text,
                                  percentageOfSales: double.parse(
                                    salesController.text,
                                  ),
                                  stars: stars,
                                  userModel: UserModel$Create(
                                    phone: phoneController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    birthDate: birthDate,
                                  ),
                                ),
                              ),
                            );
                        context.pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            CircleAvatar(
                              radius: 65,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.onBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    color: context.colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
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
                            CustomTextField(
                              dense: false,
                              controller: firstNameController,
                              focusNode: firstNameFocusNode,
                              textInputAction: TextInputAction.next,
                              label: 'Имя',
                              keyboardType: TextInputType.name,
                            ),
                            CustomTextField(
                              controller: lastNameController,
                              label: 'Фамилия',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                            ),
                            CustomTextField(
                              controller: phoneController,
                              focusNode: phoneFocusNode,
                              label: 'Телефон',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [RuPhoneInputFormatter()],
                              onChanged: _checkPhoneNumber,
                            ),
                            CustomTextField(
                              controller: emailController,
                              label: 'Почта',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomTextField(
                              controller: addressController,
                              textInputAction: TextInputAction.next,
                              focusNode: addressFocusNode,
                              label: 'Адрес проживания',
                              keyboardType: TextInputType.streetAddress,
                            ),
                            DatePickerButton(
                              initialDate: birthDate,
                              onDateSelected: (day) => birthDate = day,
                            ),
                            const SizedBox(height: 32),
                            const HeaderWidget(label: 'Рабочая информация'),
                            DatePickerButton(
                              initialDate: dateOfEmployment,
                              onDateSelected: (day) => dateOfEmployment = day,
                            ),
                            CustomTextField(
                              controller: descriptionController,
                              textInputAction: TextInputAction.next,
                              dense: false,
                              label: 'Описание сотрудника',
                              keyboardType: TextInputType.multiline,
                            ),
                            CustomTextField(
                              controller: salesController,
                              focusNode: salesFocusNode,
                              textInputAction: TextInputAction.done,
                              label: 'Процент от продаж',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              onChanged: _checkSales,
                            ),
                            const SizedBox(height: 16 + 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  void _checkPhoneNumber(String value) {
    if ((value.length == 18 && value.startsWith('+')) ||
        (value.length == 17 && value.startsWith('8'))) {
      phoneFocusNode.unfocus();
      FocusScope.of(context).requestFocus(addressFocusNode);
    }
  }

  ///
  void _checkSales(String value) {
    if (value.length == 3) {
      salesFocusNode.unfocus();
    }
  }
}
