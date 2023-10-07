import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import 'components/category_list_tile.dart';
import 'components/header_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                Divider(),
                CategoryListTile(
                  icon: Icons.account_circle_rounded,
                  title: 'Личная информация',
                  size: 25,
                ),
                // Divider(),
                // CategoryListTile(
                //   icon: Icons.people_rounded,
                //   title: 'Сотрудники',
                // ),
                Divider(),
                CategoryListTile(
                  icon: Icons.extension_rounded,
                  title: 'Услуги',
                ),
                Divider(),
                CategoryListTile(
                  icon: Icons.event,
                  title: 'Онлайн запись',
                ),
                Divider(),
                CategoryListTile(
                  icon: Icons.family_restroom_rounded,
                  title: 'Клиенты',
                ),
                Divider(),
                // TODO: Move into separated screen in NavBar
                // CategoryListTile(
                //   icon: Icons.chat_rounded,
                //   title: 'Чаты',
                // ),
                // Divider(),
                CategoryListTile(
                  icon: Icons.account_balance_rounded,
                  title: 'Финансы',
                  size: 23,
                ),
                Divider(),
                CategoryListTile(
                  icon: Icons.markunread_rounded,
                  title: 'Рассылка',
                  size: 23,
                ),
                Divider(),
                CategoryListTile(
                  icon: Icons.loyalty_rounded,
                  title: 'Скидки',
                  size: 23,
                ),
                Divider(),
                CategoryListTile(
                  icon: Icons.settings_rounded,
                  title: 'Настройки',
                  size: 23,
                ),
                Divider(),
                CategoryListTile(
                  icon: Icons.exit_to_app,
                  title: 'Выйти',
                  size: 23,
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
