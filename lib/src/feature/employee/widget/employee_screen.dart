import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/feature/staff/model/employee.dart';
import 'package:ln_employee/src/feature/staff/widget/staff_screen.dart';

import '/src/common/utils/extensions/context_extension.dart';

///
class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key, required this.employee});

  ///
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController()
      ..text = employee.userModel.firstName;
    final lastNameController = TextEditingController()
      ..text = employee.userModel.lastName;
    final nicknameController = TextEditingController()
      ..text = employee.userModel.username;
    final phoneController = TextEditingController()
      ..text = employee.userModel.phone;
    final addressController = TextEditingController()..text = employee.address;
    final emailController = TextEditingController()
      ..text = employee.userModel.email;

    /// TODO: Make calendar
    final birthDateController = TextEditingController()
      ..text = employee.userModel.birthDate.toString();

    final contractNumberController = TextEditingController()
      ..text = employee.contractNumber;

    /// TODO: Make addable list of specializations + oklad.
    final jobPlaceController = TextEditingController()
      ..text =
          '${employee.jobPlaceModel.name} ${employee.jobPlaceModel.oklad.toString()}';

    /// TODO: Redirect to another page(?) with description edition,
    /// or make huge TextField.
    final descriptonController = TextEditingController()
      ..text = employee.description;

    /// TODO: Make calendar.
    final dateOfEmploymentController = TextEditingController()
      ..text = employee.dateOfEmployment.toString();

    /// TODO: Make showModalBottomSheet.
    final salonController = TextEditingController()
      ..text = employee.salonModel.address;

    /// TODO: Make DropDownButton.
    final percentageOfSalesController = TextEditingController()
      ..text = employee.percentageOfSales.toString();

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: context.colorScheme.background,
            surfaceTintColor: context.colorScheme.background,
            toolbarHeight: 180,
            title: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: 8),
                Text(
                  '${employee.userModel.firstName} ${employee.userModel.lastName}',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ],
            ),
            floating: true,
            pinned: true,
            stretch: true,
            leading: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: IconButton(
                  /// TODO: Button "Delete employee here"
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_outlined),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size(300, 68),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '24',
                          style: context.textTheme.titleLarge!.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        Text(
                          'Кол-во клиентов',
                          style: context.textTheme.titleSmall!.copyWith(
                            fontFamily: FontFamily.geologica,
                            color: const Color(0xFFA8A6A6),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '126',
                          style: context.textTheme.titleLarge!.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        Text(
                          'Дней отработано',
                          style: context.textTheme.titleSmall!.copyWith(
                            fontFamily: FontFamily.geologica,
                            color: const Color(0xFFA8A6A6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: SliverList(
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
                            Text(
                              'Рейтинг',
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            StarRating(rating: employee.stars)
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Личная информация',
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        CustomTextField(
                          controller: firstNameController,
                          dense: false,
                          label: 'Имя',
                        ),
                        CustomTextField(
                          controller: lastNameController,
                          label: 'Фамилия',
                        ),
                        CustomTextField(
                          controller: nicknameController,
                          label: 'Никнейм',
                        ),
                        CustomTextField(
                          controller: phoneController,
                          label: 'Номер телефона',
                        ),
                        CustomTextField(
                          controller: addressController,
                          label: 'Домашний адрес',
                        ),
                        CustomTextField(
                          controller: emailController,
                          label: 'Электронный адрес',
                        ),
                        CustomTextField(
                          controller: birthDateController,
                          label: 'Дата рождения',
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Рабочая информация',
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        CustomTextField(
                          dense: false,
                          controller: salonController,
                          label: 'Салон',
                        ),
                        CustomTextField(
                          controller: contractNumberController,
                          label: 'Номер договора',
                        ),
                        CustomTextField(
                          controller: jobPlaceController,
                          label: 'Специальность + Оклад',
                        ),
                        CustomTextField(
                          controller: descriptonController,
                          label: 'Описание сотрудника',
                        ),
                        CustomTextField(
                          controller: dateOfEmploymentController,
                          label: 'Дата принятия на работу',
                        ),
                        CustomTextField(
                          controller: percentageOfSalesController,
                          label: 'Процент от продаж',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.dense = true,
  });

  final TextEditingController controller;

  final bool dense;

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dense ? 10 : 4),
      child: TextFormField(
        controller: controller,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
        decoration: InputDecoration(
          labelStyle: context.textTheme.bodyMedium!.copyWith(
            color: context.colorScheme.primary,
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA8A6A6)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA8A6A6)),
          ),
          labelText: label,
          isDense: true,
        ),
      ),
    );
  }
}
