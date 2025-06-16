import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class GoalSelectionStep extends RegisterStepWidget {
  const GoalSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.whatIsYourGoal,
          subtitle: StringsManager.goalPersonalizedPlan,
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GoalsScreen(
        items: const [
          StringsManager.gainWeight,
          StringsManager.loseWeight,
          StringsManager.getFitter,
          StringsManager.gainMoreFlexible,
          StringsManager.learnTheBasic,
        ],
        onNext: (selectedValue) {
          cubit.updateUserData('goal', selectedValue);
          cubit.nextStep();
        },
      ),
    );
  }
}
