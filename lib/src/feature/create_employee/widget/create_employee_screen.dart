import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/utils/phone_input_formatter.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/common/widget/header.dart';
import 'package:ln_employee/src/common/widget/star_rating.dart';
import 'package:ln_employee/src/common/widget/custom_text_field.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  /// User information
  late final firstNameController = TextEditingController();
  late final lastNameController = TextEditingController();
  late final phoneController = TextEditingController();
  late final addressController = TextEditingController();

  /// Employee information
  late final contractNumberController = TextEditingController();
  late final starsController = TextEditingController();
  // TODO(zhorenty): Make huge TextField.
  late final descriptonController = TextEditingController();
  late final emailController = TextEditingController();
  // TODO(zhorenty): Make DropDownButton or something.
  late final salesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int stars = 3;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: MediaQuery.sizeOf(context).height / 1.32,
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
                  onPressed: () => context.pop(),
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
                        const CustomTextField(
                          dense: false,
                          label: 'Имя',
                          keyboardType: TextInputType.name,
                        ),
                        const CustomTextField(
                          label: 'Фамилия',
                          keyboardType: TextInputType.name,
                        ),
                        CustomTextField(
                          label: 'Телефон',
                          keyboardType: TextInputType.phone,
                          inputFormatters: [RuPhoneInputFormatter()],
                        ),
                        const CustomTextField(
                          label: 'Адрес проживания',
                          keyboardType: TextInputType.streetAddress,
                        ),
                        const SizedBox(height: 32),
                        const HeaderWidget(label: 'Рабочая информация'),

                        const CustomTextField(
                          dense: false,
                          label: 'Описание сотрудника',
                          keyboardType: TextInputType.multiline,
                        ),
                        const CustomTextField(
                          label: 'Специализация',
                          keyboardType: TextInputType.number,
                        ),
                        // Изначально салон показывать нынешний выбранный
                        const CustomTextField(
                          label: 'Салон',
                          keyboardType: TextInputType.number,
                        ),
                        const CustomTextField(
                          label: 'Процент от продаж',
                          keyboardType: TextInputType.number,
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
  }
}
