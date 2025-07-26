import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class GoalSelectionStep extends RegisterStepWidget {
  GoalSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.whatIsYourGoal.tr(),
          subtitle: StringsManager.goalPersonalizedPlan.tr(),
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GoalsScreen(
        items: [
          StringsManager.gainWeight.tr(),
          StringsManager.loseWeight.tr(),
          StringsManager.getFitter.tr(),
          StringsManager.gainMoreFlexible.tr(),
          StringsManager.learnTheBasic.tr(),
        ],
        onNext: (selectedValue) {
          cubit.updateUserData('goal', selectedValue);
          cubit.nextStep();
        },
      ),
    );
  }
}
