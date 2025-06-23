import 'package:flutter/material.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/routes/route_not_found.dart';
import 'package:super_fitness/features/auth/login/presentation/view/login_screen.dart';
import 'package:super_fitness/features/home/chatBot/presentation/view/chatBot_view.dart';
import 'package:super_fitness/features/home/chatBot/presentation/view/startChat_view.dart';
import 'package:super_fitness/features/edit_profile/presentation/views/edit_profile_view.dart';
import 'package:super_fitness/features/forget_password/presentaion/create_new_pass_screen/view/create_new_password_screen.dart';
import 'package:super_fitness/features/forget_password/presentaion/forgot_password_screen/view/forgot_password_screen.dart';
import 'package:super_fitness/features/forget_password/presentaion/otp_verification_screen/view/otp_verification_screen.dart';
import 'package:super_fitness/features/auth/register/presentation/views/register_view.dart';
import 'package:super_fitness/features/intro/onboarding_screen/view/onboarding_screen.dart';
import 'package:super_fitness/features/intro/splash_screen/view/splash_screen.dart';

import '../../features/home/presentation/view/homeScreen.dart';

Route manageRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    case AppRoutes.homeScreen:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
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
    case AppRoutes.registerScreen:
      return MaterialPageRoute(
        builder: (context) => RegisterView(),
      );
    case AppRoutes.onBoardingScreen:
      return MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      );
    case AppRoutes.forgetPasswordScreen:
      return MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      );
    case AppRoutes.otpVerificationScreen:
      return MaterialPageRoute(
        builder: (context) => const OtpVerificationScreen(),
      );
    case AppRoutes.createNewPasswordScreen:
      return MaterialPageRoute(
        builder: (context) => const CreateNewPasswordScreen(),
        // builder: (context) => OnboardingScreen(),
      );
    case AppRoutes.editProfileScreen:
      return MaterialPageRoute(
        builder: (context) => const EditProfileView(),
        // builder: (context) => OnboardingScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const RouteNotFound(),
      );
  }
}
