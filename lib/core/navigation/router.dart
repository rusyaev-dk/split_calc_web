import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/calc/presentation/screens/calc_screen.dart';
import 'package:flutter_app_template/features/home/presentation/presentation.dart';
import 'package:flutter_app_template/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter({
    required bool includePrefixMatches,
    required List<NavigatorObserver> navigatorObservers,
  }) {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      observers: navigatorObservers,
      routes: _routes,
    );
  }

  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, _) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, _) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'calc',
          name: 'calc',
          builder: (context, _) => const CalcScreen(),
        ),
      ],
    ),
  ];
}

// class AppRouter {
//   /// {@macro app_router}
//   const AppRouter();

//   /// Ключ для доступа к корневому навигатору приложения
//   static final rootNavigatorKey = GlobalKey<NavigatorState>();

//   /// Начальный роут приложения
//   static String get initialLocation => '/main';

//   /// Метод для создания экземпляра GoRouter
//   static GoRouter createRouter(IDebugService debugService) {
//     return GoRouter(
//       navigatorKey: rootNavigatorKey,
//       initialLocation: initialLocation,
//       observers: [debugService.routeObserver],
//       routes: [
//         StatefulShellRoute.indexedStack(
//           parentNavigatorKey: rootNavigatorKey,
//           builder: (context, state, navigationShell) =>
//               RootScreen(navigationShell: navigationShell),
//           branches: [
//             MainRoutes.buildShellBranch(),
//             ProfileRoutes.buildShellBranch(),
//           ],
//         ),
//         GoRoute(
//           path: '/splash',
//           builder: (context, state) => const SplashScreen(),
//         ),
//       ],
//     );
//   }
// }
