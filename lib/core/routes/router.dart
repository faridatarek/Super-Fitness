import 'package:flutter/material.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/routes/route_not_found.dart';
import 'package:super_fitness/features/intro/onboarding_screen/view/onboarding_screen.dart';
import 'package:super_fitness/features/intro/splash_screen/view/splash_screen.dart';

import '../../features/home/presentation/view/homeScreen.dart';

Route manageRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(
        builder: (context) =>  SplashScreen(),
      );
    case AppRoutes.homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case AppRoutes.onBoardingScreen:
      return MaterialPageRoute(
        builder: (context) =>  OnboardingScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const RouteNotFound(),
      );
  }
}
