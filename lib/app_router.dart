// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/splash_page.dart';

abstract class AppRouter {
  static const splashPage = '/splashPage';
  static const myHomePage = '/myHomePage';
  // Reusable right-to-left slide transition
  static CustomTransitionPage<T> buildPageWithSlideTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // From right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // Reusable bottom-to-top slide transition
  static CustomTransitionPage<T> buildPageWithBottomToTopTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // From bottom to top
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Configures the app's navigation routes using GoRouter.
  static final GoRouter router = GoRouter(
    initialLocation: splashPage,
    routes: [
      GoRoute(
        path: splashPage,
        pageBuilder: (context, state) => buildPageWithBottomToTopTransition(
          context: context,
          state: state,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: myHomePage,
        pageBuilder: (context, state) => buildPageWithBottomToTopTransition(
          context: context,
          state: state,
          child: const MyHomePage(),
        ),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
}
