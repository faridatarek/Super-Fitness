import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/register_step_widget.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/gender_selector.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class GenderSelectionStep extends RegisterStepWidget {
  GenderSelectionStep({super.key, required super.cubit})
      : super(
          title: StringsManager.tellUsAboutYourself.tr(),
          subtitle: StringsManager.weNeedToKnowYourGender.tr(),
        );

  @override
  Widget buildStepContent(BuildContext context) {
    return GenderSelection(
      onNextPressed: () {
        final gender = context.read<GenderProvider>().selectedGender ??
            StringsManager.female.toLowerCase().tr();
        cubit.updateUserData('gender', gender);
        cubit.nextStep();
      },
    );
  }
}
