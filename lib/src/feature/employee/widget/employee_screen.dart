import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/employee/bloc/employee_bloc.dart';

///
class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key, required this.employeeId});

  ///
  final int employeeId;

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(EmployeeEvent.fetch(widget.employeeId));
    super.initState();
  }

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
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
                      state.employee!.description,
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
                            const Text('Персональная информация'),
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Персональная информация'),
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
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
