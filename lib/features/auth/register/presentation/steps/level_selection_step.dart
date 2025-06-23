import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class LevelSelectionStep extends RegisterStepWidget {
  final Map<String, String> levelMap = const {
    StringsManager.rookie: 'level1',
    StringsManager.beginner: 'level2',
    StringsManager.intermediate: 'level3',
    StringsManager.advance: 'level4',
    StringsManager.trueBeast: 'level5',
  };

  const LevelSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.regularYourActivityLevel,
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
