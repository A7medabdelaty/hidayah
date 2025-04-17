import 'package:flutter/material.dart';
import 'package:hidayah/features/home/presentation/view/home_view.dart';

import '../../features/splash/presentation/screens/splash_screen.dart';
import '../routing/routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _createRoute(const SplashScreen());
      case Routes.homeScreen:
        return _createRoute(const HomeView());
      default:
        return null;
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
