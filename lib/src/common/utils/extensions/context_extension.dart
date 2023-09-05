import 'package:flutter/material.dart';

import '/src/common/localization/app_localization.dart';

extension BuildContextX on BuildContext {
  /// Returns localized string from [AppLocalization].
  GeneratedLocalization stringOf() =>
      AppLocalization.stringOf<GeneratedLocalization>(this);

  /// Returns [ColorScheme] from [BuildContext]
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns [TextTheme] from [BuildContext].
  TextTheme get textTheme => Theme.of(this).textTheme;
}
