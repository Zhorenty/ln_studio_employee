import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/src/feature/timetable/widget/employee_timetables.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// {@template timetable_screen}
/// Timetable screen.
/// {@endtemplate}
class TimetableScreen extends StatelessWidget {
  /// {@macro timetable_screen}
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: context.colors.onBackground,
                surfaceTintColor: context.colors.onBackground,
                toolbarHeight: 90,
                title: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Здравствуйте, Евгений',
                      style: context.fonts.titleLarge!.copyWith(
                        color: context.colors.primary,
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ),
                ),
              ),
              const EmployeeTimetables(),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: context.colors.onBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.camera),
                            title: const Text('Camera'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Photo Library'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: kIsWeb ? 65 : 120),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'ул. Степана Разина, д. 72',
                      style: context.fonts.titleMedium!.copyWith(
                        fontSize: 17,
                        color: context.colors.onBackground,
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.colors.onBackground,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
