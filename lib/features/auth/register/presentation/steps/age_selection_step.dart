import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class AgeSelectionStep extends RegisterStepWidget {
  const AgeSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.howOldAreYou,
          subtitle: StringsManager.agePersonalizedPlan,
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NumberSelectorProvider(initialValue: 16),
      child: NumberSelector(
        min: 16,
        max: 50,
        labelText: StringsManager.year,
        onNextPressed: (selectedValue) {
          cubit.updateUserData('age', selectedValue);
          cubit.nextStep();
        },
        buttonText: StringsManager.next,
      ),
    );
  }
}
