import 'package:flutter/material.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/routes/route_not_found.dart';

import '../../features/home/presentation/view/homeScreen.dart';

Route manageRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const RouteNotFound(),
      );
  }
}
