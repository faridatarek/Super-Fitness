import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/intro/onboarding_screen/view/widgets/custom_scaffold.dart';
import 'package:super_fitness/features/intro/onboarding_screen/view/widgets/on_boarding_page.dart';
import 'package:super_fitness/features/intro/onboarding_screen/view/widgets/onboarding_controls.dart';

import '../data/on_boarding_data.dart';
import '../view_model/onboarding_view_model.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<OnboardingCubit>();

          return CustomScaffold(
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: cubit.getPageController,
                        itemCount: OnBoardingData.onboardingData.length,
                        onPageChanged: cubit.updatePage,
                        itemBuilder: (context, index) {
                          return OnboardingPage(
                            image: OnBoardingData.onboardingData[index]["image"]!,
                            title: OnBoardingData.onboardingData[index]["title"]!,
                            description: OnBoardingData.onboardingData[index]["description"]!,
                          );
                        },
                      ),
                      const SkipButton(),
                    ],
                  ),
                ),
                OnboardingControls(
                  pageController: cubit.getPageController,
                  totalPages: OnBoardingData.onboardingData.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
