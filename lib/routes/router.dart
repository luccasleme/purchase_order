import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchase_order/features/auth/presentation/pages/login.dart';
import 'package:purchase_order/features/auth/presentation/pages/splash.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';
import 'package:purchase_order/features/orders/presentation/pages/detail.dart';
import 'package:purchase_order/features/orders/presentation/pages/home.dart';
import 'package:purchase_order/features/orders/presentation/pages/task.dart';
import 'package:purchase_order/routes/app_routes.dart';

class _AuthStateNotifier extends ChangeNotifier {
  final Ref _ref;

  _AuthStateNotifier(this._ref) {
    _ref.listen(authProvider, (previous, next) {
      notifyListeners();
    });
  }
}

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: _AuthStateNotifier(ref),
      redirect: (context, state) {
        final authState = ref.read(authProvider);
        final isLoading = authState.isLoading;
        final isLoggedIn = authState.user != null;
        final isGoingToSplash = state.matchedLocation == AppRoutes.splash;
        final isGoingToLogin = state.matchedLocation == AppRoutes.login;

        // If loading, stay on splash
        if (isLoading && !isGoingToSplash) {
          return AppRoutes.splash;
        }

        // If not loading and not logged in, go to login
        if (!isLoading && !isLoggedIn && !isGoingToLogin) {
          return AppRoutes.login;
        }

        // If not loading and logged in and on splash/login, go to home
        if (!isLoading && isLoggedIn && (isGoingToSplash || isGoingToLogin)) {
          return AppRoutes.home;
        }

        // No redirect needed
        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.taskList,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            if (extra == null) {
              return const Scaffold(
                body: Center(child: Text('Missing route parameters')),
              );
            }
            return TaskListPage(
              title: extra['title'] as String,
              i: extra['index'] as int,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.detail,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            if (extra == null) {
              return const Scaffold(
                body: Center(child: Text('Missing route parameters')),
              );
            }
            return TaskDetail(
              i: extra['i'] as int,
              index: extra['index'] as int,
            );
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Page not found: ${state.matchedLocation}'),
        ),
      ),
    );
  },
);
