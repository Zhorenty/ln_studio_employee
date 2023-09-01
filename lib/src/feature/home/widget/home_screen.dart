import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// {@template wardrobe_screen}
/// Wardrobe screen.
/// {@endtemplate}
class WardrobeScreen extends StatelessWidget {
  /// {@macro wardrobe_screen}
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.onBackground,
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 8),
                child: Text(
                  'ул. Степана Разина, д. 72',
                  style: context.fonts.bodyMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 4, top: 8),
                child: Icon(Icons.arrow_forward_ios, size: 12),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: context.colors.primary,
              child: Icon(
                Icons.person,
                color: context.colors.onBackground,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.stringOf().wardrobeEmpty,
          style: context.fonts.titleMedium?.copyWith(
            fontFamily: FontFamily.playfair,
            color: context.colors.primary,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Записаться',
          style: context.fonts.bodyMedium?.copyWith(
            color: context.colors.onBackground,
            fontFamily: FontFamily.playfair,
          ),
        ),
        backgroundColor: context.colors.primary,
        onPressed: () {},
      ),
    );
  }
}
