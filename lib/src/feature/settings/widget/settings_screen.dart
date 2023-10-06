import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';

import '/src/common/utils/extensions/context_extension.dart';
import 'components/category_list_tile.dart';
import 'components/custom_divider.dart';
import 'components/header_list_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Профиль',
                style: context.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontFamily: FontFamily.geologica,
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
            SliverList.list(
              children: const [
                HeaderListTile(),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.account_circle_rounded,
                  title: 'Личная информация',
                  size: 25,
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.extension_rounded,
                  title: 'Услуги',
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.event,
                  title: 'Онлайн запись',
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.group_rounded,
                  title: 'Клиенты',
                ),
                CustomDivider(),
                // TODO: Move into separated screen in NavBar
                CategoryListTile(
                  icon: Icons.chat_rounded,
                  title: 'Чаты',
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.account_balance_rounded,
                  title: 'Финансы',
                  size: 23,
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.markunread_rounded,
                  title: 'Рассылка',
                  size: 23,
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.loyalty_rounded,
                  title: 'Скидки',
                  size: 23,
                ),
                CustomDivider(),
                CategoryListTile(
                  icon: Icons.exit_to_app,
                  title: 'Выйти',
                  size: 23,
                ),
                CustomDivider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
