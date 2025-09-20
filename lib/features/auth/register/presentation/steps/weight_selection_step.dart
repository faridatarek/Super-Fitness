import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class WeightSelectionStep extends RegisterStepWidget {
  WeightSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.whatIsYourWeight.tr(),
          subtitle: StringsManager.weightPersonalizedPlan.tr(),
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NumberSelectorProvider(initialValue: 30),
      child: NumberSelector(
        min: 30,
        max: 150,
        labelText: StringsManager.kg.tr(),
        onNextPressed: (selectedValue) {
          cubit.updateUserData('weight', selectedValue);
          cubit.nextStep();
        },
        buttonText: StringsManager.next.tr(),
      ),
    );
  }
}
