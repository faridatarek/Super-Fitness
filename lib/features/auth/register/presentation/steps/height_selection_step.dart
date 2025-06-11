import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/step_with_back_button.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class HeightSelectionStep extends StatelessWidget {
  final RegisterCubit cubit;

  const HeightSelectionStep({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return StepWithBackButton(
      onBackPressed: () {
        cubit.previousStep();
      },
      currentStepIndex: cubit.currentStepIndex,
      totalSteps: cubit.totalSteps,
      child: _buildNumberSelector(
        context,
        StringsManager.cm,
        30,
        250,
        'height',
        StringsManager.whatIsYourHeight,
        StringsManager.heightPersonalizedPlan,
      ),
    );
  }

  Widget _buildNumberSelector(BuildContext context, String label, int min,
      int max, String field, String title, String subtitle) {
    return ChangeNotifierProvider(
      create: (_) => NumberSelectorProvider(initialValue: min),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: AppTextStyles.font20W800White()
                      .copyWith(fontWeight: FontWeight.w900)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p16),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(subtitle, style: AppTextStyles.font16W500White())),
          ),
          NumberSelector(
            min: min,
            max: max,
            labelText: label,
            onNextPressed: (selectedValue) {
              cubit.updateUserData(field, selectedValue);
              cubit.nextStep();
            },
            buttonText: StringsManager.next,
          ),
        ],
      ),
    );
  }
}
