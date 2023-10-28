import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/assets.gen.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/auth/widget/auth_scope.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import 'components/category_list_tile.dart';
import 'components/header_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationScope.of(context);

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
              CategoryListTile(
                onTap: () => context.goNamed('news'),
                icon: Icons.article_rounded,
                title: 'Новости',
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
              CategoryListTile(
                onTap: () => showExit(context, auth.signOut),
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

  Future<dynamic> showExit(
    BuildContext context,
    void Function()? onPressed,
  ) =>
      ModalPopup.show(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Уже уходите?',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
            const SizedBox(height: 16),
            Assets.images.exit.image(scale: 8),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                fixedSize: Size(
                  MediaQuery.sizeOf(context).width - 50,
                  50,
                ),
                backgroundColor: context.colorScheme.primary,
              ),
              child: Text(
                'Я остаюсь',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                  color: context.colorScheme.onBackground,
                ),
              ),
              onPressed: () => context.pop(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                fixedSize: Size(
                  MediaQuery.sizeOf(context).width - 50,
                  50,
                ),
                backgroundColor: context.colorScheme.onBackground,
              ),
              onPressed: onPressed,
              child: Text(
                'Выйти',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
          ],
        ),
      );
  // showAdaptiveDialog(
  //   context: context,
  //   builder: (context) {
  //     return AlertDialog(
  //       backgroundColor: context.colorScheme.onBackground,
  //       titlePadding: const EdgeInsets.all(16),
  // title: Text(
  //   'Вы точно хотите выйти из аккаунта?',
  //   style: context.textTheme.titleLarge?.copyWith(
  //     fontFamily: FontFamily.geologica,
  //   ),
  // ),
  //       actionsAlignment: MainAxisAlignment.spaceBetween,
  //       actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
  //       actions: <Widget>[
  //         TextButton(
  //           style: TextButton.styleFrom(
  //             textStyle: context.textTheme.bodyLarge?.copyWith(
  //               fontFamily: FontFamily.geologica,
  //             ),
  //           ),
  //           child: const Text('Нет'),
  //           onPressed: () => context.pop(),
  //         ),
  //         TextButton(
  //           style: TextButton.styleFrom(
  //             textStyle: context.textTheme.bodyLarge?.copyWith(
  //               fontFamily: FontFamily.geologica,
  //             ),
  //           ),
  //           onPressed: onPressed,
  //           child: const Text('Да, выйти'),
  //         ),
  //       ],
  //     );
  //   },
  // );
}
