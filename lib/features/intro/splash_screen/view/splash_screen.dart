import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/utils/color_manager.dart';
import '../../../../utils/assets_manager.dart';
import '../../onboarding_screen/view/onboarding_screen.dart';
import '../../onboarding_screen/view_model/onboarding_view_model.dart';
import '../view_model/splash_state.dart';
import '../view_model/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startTimer(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashFinished) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const OnboardingScreen(),
              ),
            );

          }
        },
        child: const Scaffold(
          body: Center(
            child: Image(
              image: AssetImage(ImageAssets.logo),
            ),
          ),
        ),
      ),
    );
  }
}
