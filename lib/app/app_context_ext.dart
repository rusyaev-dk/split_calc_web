import 'package:flutter/material.dart';
import 'package:split_calculator/l10n/generated/l10n.dart';
import 'package:split_calculator/uikit/uikit.dart';

extension AppContextExt on BuildContext {
  AppColorScheme get colorScheme => AppColorScheme.of(this);

  AppTextScheme get textScheme => AppTextScheme.of(this);

  S get l10n => S.of(this);
}
