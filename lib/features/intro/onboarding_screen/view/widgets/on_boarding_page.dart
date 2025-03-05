import 'package:flutter/material.dart';
import 'package:super_fitness/features/intro/onboarding_screen/view/widgets/blured_countainer.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 70),
        Expanded(
          child: Image.asset(image),
        ),
        const SizedBox(height: 20),
        BlurredContainer(
          condition: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font24W800White(),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font18W400White(
                    fontSize: 16,
                    color: ColorManager.lightGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
