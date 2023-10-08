import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import 'components/category_list_tile.dart';
import 'components/header_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              const HeaderListTile(),
              const Divider(),
              const CategoryListTile(
                icon: Icons.account_circle_rounded,
                title: 'Личная информация',
                size: 25,
              ),
              // Divider(),
              // CategoryListTile(
              //   icon: Icons.people_rounded,
              //   title: 'Сотрудники',
              // ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.extension_rounded,
                title: 'Услуги',
              ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.event,
                title: 'Онлайн запись',
              ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.family_restroom_rounded,
                title: 'Клиенты',
              ),
              const Divider(),
              // TODO: Move into separated screen in NavBar
              // CategoryListTile(
              //   icon: Icons.chat_rounded,
              //   title: 'Чаты',
              // ),
              // Divider(),
              const CategoryListTile(
                icon: Icons.account_balance_rounded,
                title: 'Финансы',
                size: 23,
              ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.markunread_rounded,
                title: 'Рассылка',
                size: 23,
              ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.loyalty_rounded,
                title: 'Скидки',
                size: 23,
              ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.settings_rounded,
                title: 'Настройки',
                size: 23,
              ),
              const Divider(),
              const CategoryListTile(
                icon: Icons.exit_to_app,
                title: 'Выйти',
                size: 23,
              ),
              const Divider(),
              SizedBox(height: MediaQuery.sizeOf(context).height / 8)
            ],
          ),
        ],
      ),
    );
  }
}
