import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class LevelSelectionStep extends RegisterStepWidget {
  final Map<String, String> levelMap = {
    StringsManager.rookie.tr(): 'level1',
    StringsManager.beginner.tr(): 'level2',
    StringsManager.intermediate.tr(): 'level3',
    StringsManager.advance.tr(): 'level4',
    StringsManager.trueBeast.tr(): 'level5',
  };

  LevelSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.regularYourActivityLevel.tr(),
          subtitle: '',
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GoalsScreen(
        items: levelMap.keys.toList(),
        onNext: (selectedValue) {
          final mappedLevel = levelMap[selectedValue] ?? 'level1';
          cubit.updateUserData('activityLevel', mappedLevel);
          cubit.nextStep();
        },
      ),
    );
  }
}
