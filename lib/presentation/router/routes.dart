import 'package:cupid/presentation/screens/auth_screen/login_screen.dart';
import 'package:cupid/presentation/screens/auth_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../application/exceptions/route_exception.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash_screen/splash_screen.dart';

class AppRouter {
  static const String splash = 'splash';
  static const String register = 'Register';
  static const String login = 'Login';
  static const String profile = 'Profile';
  static const String dashBoard = 'DashBoard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransition(
            child: const SplashScreen(), type: PageTransitionType.leftToRight);
      case register:
        return PageTransition(
            child: RegisterScreen(), type: PageTransitionType.leftToRight);
      case login:
        return PageTransition(
            child: LoginScreen(), type: PageTransitionType.leftToRight);
      case dashBoard:
        return PageTransition(
            child: const DashBoard(), type: PageTransitionType.leftToRight);
      case profile:
        return PageTransition(
            child: Profile(), type: PageTransitionType.leftToRight);

      default:
        throw const RouteException('Route not found!');
    }
  }
}
