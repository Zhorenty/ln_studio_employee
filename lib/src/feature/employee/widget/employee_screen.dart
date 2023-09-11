import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/widget/star_rating.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/employee_state.dart';
import 'package:ln_employee/src/feature/employee/widget/expanded_app_bar.dart';
import 'package:ln_employee/src/feature/employee/widget/skeleton_employee_screen.dart';
import 'package:ln_employee/src/feature/staff/bloc/staff_bloc.dart';
import 'package:ln_employee/src/feature/staff/bloc/staff_event.dart';

import '/src/common/utils/extensions/context_extension.dart';
import 'custom_text_field.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EmployeeScreen({super.key, required this.employeeid});

  /// EmployeeModel of this [EmployeeScreen].
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

  late final firstNameController = TextEditingController();
  late final lastNameController = TextEditingController();
  late final phoneController = TextEditingController();
  late final addressController = TextEditingController();
  // TODO: Make calendar
  late final birthDateController = TextEditingController();
  late final contractNumberController = TextEditingController();
  late final starsController = TextEditingController();
  // TODO: Make huge TextField.
  late final descriptonController = TextEditingController();
  late final emailController = TextEditingController();
  // TODO: Make calendar
  late final dateOfEmploymentController = TextEditingController();
  // TODO: Make DropDownButton or something.
  late final percentageOfSalesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state.employee == null) {
          return const SkeletonEmployeeScreen();
        } else {
          return Builder(
            builder: (context) {
              firstNameController.text = state.employee!.userModel.firstName;
              lastNameController.text = state.employee!.userModel.lastName;
              phoneController.text = state.employee!.userModel.phone;
              addressController.text = state.employee!.address;
              birthDateController.text =
                  state.employee!.userModel.birthDate.toString();
              contractNumberController.text = state.employee!.contractNumber;
              starsController.text = state.employee!.stars.toString();
              descriptonController.text = state.employee!.description;
              emailController.text = state.employee!.userModel.email;
              dateOfEmploymentController.text =
                  state.employee!.dateOfEmployment.toString();
              percentageOfSalesController.text =
                  state.employee!.percentageOfSales.toString();

              return Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    context.read<EmployeeBloc>().add(
                          EmployeeEvent.editEmployee(
                            id: state.employee!.id,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            description: descriptonController.text,
                            contractNumber: contractNumberController.text,
                            percentageOfSales: double.parse(
                              percentageOfSalesController.text,
                            ),
                            stars: int.parse(starsController.text),
                            email: emailController.text,
                          ),
                        );
                  },
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
                        '${state.employee!.userModel.firstName} ${state.employee!.userModel.lastName}',
                        style: context.textTheme.titleLarge!.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      leading: Text(
                        '24',
                        style: context.textTheme.titleLarge!.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      trailing: Text(
                        '126',
                        style: context.textTheme.titleLarge!.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      onPressed: () {
                        _refreshStaff();
                        context.pop();
                      },
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: () => _fetch(state.employee!.id),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Рейтинг',
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontFamily: FontFamily.geologica,
                                        ),
                                      ),
                                      StarRating(
                                        rating: state.employee!.stars,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16 + 8),
                                  Text(
                                    'Личная информация',
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
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
                                    controller: phoneController,
                                    label: 'Номер телефона',
                                  ),
                                  CustomTextField(
                                    controller: addressController,
                                    label: 'Домашний адрес',
                                  ),
                                  CustomTextField(
                                    controller: emailController,
                                    label: 'Электронная почта',
                                  ),
                                  CustomTextField(
                                    controller: birthDateController,
                                    label: 'Дата рождения',
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    'Рабочая информация',
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
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
                                    controller: contractNumberController,
                                    label: 'Номер договора',
                                  ),
                                  CustomTextField(
                                    controller: starsController,
                                    label: 'Рейтинг сотрудника',
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
            },
          );
        }
      },
    );
  }

  /// TODO: Fetch user by id.
  Future<void> _fetch(int id) async {
    context.read<EmployeeBloc>().add(EmployeeEvent.fetch(id: id));
  }

  ///
  Future<void> _refreshStaff() async {
    final block = context.read<StaffBloc>().stream.first;
    context.read<StaffBloc>().add(const StaffEvent.fetch());
    await block;
  }
}
