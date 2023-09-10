import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/widget/star_rating.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee_state.dart';
import 'package:ln_employee/src/feature/staff/bloc/staff_bloc.dart';
import 'package:ln_employee/src/feature/staff/bloc/staff_event.dart';
import 'package:ln_employee/src/feature/staff/model/employee.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EmployeeScreen({super.key, required this.employee});

  /// EmployeeModel of this [EmployeeScreen].
  final EmployeeModel employee;

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController()
      ..text = widget.employee.userModel.firstName;
    final lastNameController = TextEditingController()
      ..text = widget.employee.userModel.lastName;

    final phoneController = TextEditingController()
      ..text = widget.employee.userModel.phone;
    final addressController = TextEditingController()
      ..text = widget.employee.address;

    /// TODO: Make calendar
    final birthDateController = TextEditingController()
      ..text = widget.employee.userModel.birthDate.toString();

    final contractNumberController = TextEditingController()
      ..text = widget.employee.contractNumber;

    /// TODO: Redirect to another page(?) with description edition,
    /// or make huge TextField.
    final descriptonController = TextEditingController()
      ..text = widget.employee.description;
    final emailController = TextEditingController()
      ..text = widget.employee.userModel.email;

    /// TODO: Make calendar.
    final dateOfEmploymentController = TextEditingController()
      ..text = widget.employee.dateOfEmployment.toString();

    /// TODO: Make DropDownButton.
    final percentageOfSalesController = TextEditingController()
      ..text = widget.employee.percentageOfSales.toString();

    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colorScheme.onBackground,
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
                      '${widget.employee.userModel.firstName} ${widget.employee.userModel.lastName}',
                      style: context.textTheme.titleLarge!.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ],
                ),
                floating: true,
                pinned: true,
                leading: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: IconButton(
                      onPressed: () {
                        _fetch();
                        context.pop();
                      },
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
              CupertinoSliverRefreshControl(onRefresh: _fetch),
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
                                StarRating(rating: widget.employee.stars)
                              ],
                            ),
                            const SizedBox(height: 16 + 8),
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
                            _CustomTextField(
                              controller: firstNameController,
                              dense: false,
                              label: 'Имя',
                              onFieldSubmitted: (value) {
                                firstNameController.text = value;
                              },
                            ),
                            _CustomTextField(
                              controller: lastNameController,
                              label: 'Фамилия',
                            ),
                            _CustomTextField(
                              controller: phoneController,
                              label: 'Номер телефона',
                            ),
                            _CustomTextField(
                              controller: addressController,
                              label: 'Домашний адрес',
                            ),
                            _CustomTextField(
                              controller: emailController,
                              label: 'Электронная почта',
                            ),
                            _CustomTextField(
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
                            _CustomTextField(
                              controller: contractNumberController,
                              label: 'Номер договора',
                            ),
                            _CustomTextField(
                              controller: descriptonController,
                              label: 'Описание сотрудника',
                            ),
                            _CustomTextField(
                              controller: dateOfEmploymentController,
                              label: 'Дата принятия на работу',
                            ),
                            _CustomTextField(
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
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<EmployeeBloc>().add(
                            EmployeeEvent.editEmployee(
                              id: widget.employee.id,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              description: descriptonController.text,
                              contractNumber: contractNumberController.text,
                              percentageOfSales:
                                  widget.employee.percentageOfSales,
                              stars: widget.employee.stars,
                              email: emailController.text,
                            ),
                          );
                    },
                    child: const Text('Отправить'),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _fetch() async {
    final block = context.read<StaffBloc>().stream.first;
    context.read<StaffBloc>().add(const StaffEvent.fetch());
    await block;
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    required this.controller,
    this.onFieldSubmitted,
    this.label,
    this.dense = true,
  });

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;

  final bool dense;

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dense ? 10 : 4),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
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
