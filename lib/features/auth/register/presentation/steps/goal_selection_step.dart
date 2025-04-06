import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/step_with_back_button.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class GoalSelectionStep extends StatelessWidget {
  final RegisterCubit cubit;

  const GoalSelectionStep({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return StepWithBackButton(
      onBackPressed: () {
        cubit.previousStep();
      },
      currentStepIndex: cubit.currentStepIndex,
      totalSteps: cubit.totalSteps,
      child: _buildGoalSelector(
        context,
        StringsManager.whatIsYourGoal,
        [
          StringsManager.gainWeight,
          StringsManager.loseWeight,
          StringsManager.getFitter,
          StringsManager.gainMoreFlexible,
          StringsManager.learnTheBasic
        ],
        'goal',
      ),
    );
  }

  Widget _buildGoalSelector(
      BuildContext context, String title, List<String> items, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(title,
                style: AppTextStyles.font20W800White()
                    .copyWith(fontWeight: FontWeight.w900)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(StringsManager.goalPersonalizedPlan,
                style: AppTextStyles.font16W500White()),
          ),
        ),
        SizedBox(
          height: AppSize.s16.h,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6.h,
          child: GoalsScreen(
            items: items,
            onNext: (selectedValue) {
              cubit.updateUserData(type, selectedValue);
              cubit.nextStep();
            },
          ),
        ),
      ],
    );
  }
}
