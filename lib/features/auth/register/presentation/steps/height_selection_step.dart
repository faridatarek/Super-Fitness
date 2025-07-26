import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class HeightSelectionStep extends RegisterStepWidget {
  HeightSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.whatIsYourHeight.tr(),
          subtitle: StringsManager.heightPersonalizedPlan.tr(),
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NumberSelectorProvider(initialValue: 30),
      child: NumberSelector(
        min: 30,
        max: 250,
        labelText: StringsManager.cm.tr(),
        onNextPressed: (selectedValue) {
          cubit.updateUserData('height', selectedValue);
          cubit.nextStep();
        },
        buttonText: StringsManager.next.tr(),
      ),
    );
  }
}
