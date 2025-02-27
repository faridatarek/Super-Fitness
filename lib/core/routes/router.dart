import 'package:flutter/material.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/routes/route_not_found.dart';
import 'package:super_fitness/features/auth/login/presentation/view/login_screen.dart';
import 'package:super_fitness/features/home/chatBot/presentation/view/chatBot_view.dart';
import 'package:super_fitness/features/home/chatBot/presentation/view/startChat_view.dart';

import '../../features/home/presentation/view/homeScreen.dart';

Route manageRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homeScreen:
      return MaterialPageRoute(
        builder: (context) =>  HomeScreen(),
      );
    case AppRoutes.loginScreen:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
    case AppRoutes.ChatScreen:
      return MaterialPageRoute(
        builder: (context) => ChatScreen(),
      );
    case AppRoutes.StartchatView:
      return MaterialPageRoute(
        builder: (context) => StartchatView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const RouteNotFound(),
      );
  }
}
