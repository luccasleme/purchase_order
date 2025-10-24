import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';
import 'package:purchase_order/routes/app_routes.dart';
import 'package:purchase_order/view/pages/home.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/pages/splash.dart';
import 'package:purchase_order/view/pages/task.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authProvider);

    return GoRouter(
      initialLocation: AppRoutes.splash,
      redirect: (context, state) {
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
            final extra = state.extra as Map<String, dynamic>;
            return TaskListPage(
              title: extra['title'] as String,
              i: extra['index'] as int,
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
