import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/l10n/generated/l10n.dart';
import 'package:flutter_app_template/uikit/uikit.dart';
import 'package:provider/provider.dart';

extension AppContextExt on BuildContext {
  AppConfig get appConfig => Provider.of<AppConfig>(this);

  AppThemeData get theme => Provider.of<AppThemeData>(this);

  AppColorScheme get colorScheme => Provider.of<AppColorScheme>(this);

  AppTextScheme get textScheme => Provider.of<AppTextScheme>(this);

  S get l10n => S.of(this);
}
