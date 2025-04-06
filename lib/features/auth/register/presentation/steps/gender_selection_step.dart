import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/gender_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/step_with_back_button.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class GenderSelectionStep extends StatelessWidget {
  final RegisterCubit cubit;

  const GenderSelectionStep({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return StepWithBackButton(
      onBackPressed: () {
        cubit.previousStep();
      },
      currentStepIndex: cubit.currentStepIndex,
      totalSteps: cubit.totalSteps,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(StringsManager.tellUsAboutYourself,
                  style: AppTextStyles.font20W800White()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(StringsManager.weNeedToKnowYourGender,
                  style: AppTextStyles.font16W500White()),
            ),
          ),
          GenderSelection(
            onNextPressed: () {
              String selectedGender =
                  context.read<GenderProvider>().selectedGender ??
                      StringsManager.female.toLowerCase();
              cubit.updateUserData('gender', selectedGender);
              cubit.nextStep();
            },
            onGenderSelected: (gender) {
              cubit.updateUserData('gender', gender);
            },
          ),
        ],
      ),
    );
  }
}
