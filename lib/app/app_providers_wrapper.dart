import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:split_calculator/core/data/storage/storage.dart';
import 'package:split_calculator/core/utils/utils.dart';
import 'package:split_calculator/di/di.dart';
import 'package:split_calculator/features/calc/domain/domain.dart';
import 'package:split_calculator/features/settings/data/data.dart';
import 'package:split_calculator/features/settings/presentation/presentation.dart';

class AppProvidersWrapper extends StatelessWidget {
  const AppProvidersWrapper({
    required this.appScope,
    required this.child,
    super.key,
  });

  final AppScope appScope;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppScope>(create: (context) => appScope),
        Provider<ILogger>(create: (context) => appScope.logger),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ISettingsRepository>(
            create: (context) => SettingsRepository(
              storage: appScope.storageAggregator.sharedPrefsStorage,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SettingsCubit(
                settingsRepository: RepositoryProvider.of<ISettingsRepository>(
                  context,
                ),
                logger: appScope.logger,
              ),
            ),
            BlocProvider(
              create: (context) => CalcBloc(
                storage: SharedPrefsStorage(
                  sharedPreferences: appScope.sharedPreferences,
                ),
              ),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}
