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
    final nameController = TextEditingController();

    nameController.text = employee.address;
    return Scaffold(
      body: CustomScrollView(
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
                        CustomTextField(
                          controller: nameController,
                          label: 'Имя сотрудника',
                        ),
                        CustomTextField(
                          controller: nameController,
                          label: 'E-Mail',
                        ),
                        CustomTextField(
                          controller: nameController,
                          label: 'Номер телефона',
                        ),
                        CustomTextField(
                          controller: nameController,
                          label: 'Домашний адрес',
                        ),
                        CustomTextField(
                          controller: nameController,
                          label: 'Дата рождения',
                        ),
                        CustomTextField(
                          controller: nameController,
                          label: 'Принят',
                        ),
                        CustomTextField(
                          controller: nameController,
                          label: 'Номер договора',
                        ),
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
  const CustomTextField({super.key, required this.controller, this.label});

  final TextEditingController controller;

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
        ),
      ),
    );
  }
}
