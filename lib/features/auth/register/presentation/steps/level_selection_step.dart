import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/step_with_back_button.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class LevelSelectionStep extends StatelessWidget {
  final RegisterCubit cubit;

  const LevelSelectionStep({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> levelMap = {
      StringsManager.rookie: 'level1',
      StringsManager.beginner: 'level2',
      StringsManager.intermediate: 'level3',
      StringsManager.advance: 'level4',
      StringsManager.trueBeast: 'level5',
    };

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
              child: Text(StringsManager.regularYourActivityLevel,
                  style: AppTextStyles.font20W800White()
                      .copyWith(fontWeight: FontWeight.w900)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: GoalsScreen(
              items: levelMap.keys.toList(),
              onNext: (selectedValue) {
                String mappedLevel = levelMap[selectedValue] ?? 'level1';
                cubit.updateUserData('activityLevel', mappedLevel);
                cubit.nextStep();
              },
            ),
          ),
        ],
      ),
    );
  }
}
