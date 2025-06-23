import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/step_with_back_button.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/values_manager.dart';

abstract class RegisterStepWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final String title;
  final String subtitle;

  const RegisterStepWidget({
    super.key,
    required this.cubit,
    required this.title,
    required this.subtitle,
  });

  Widget buildStepContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return StepWithBackButton(
      onBackPressed: cubit.previousStep,
      currentStepIndex: cubit.currentStepIndex,
      totalSteps: cubit.totalSteps,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: StepHeader(title: title, subtitle: subtitle)),
          buildStepContent(context),
        ],
      ),
    );
  }
}

class StepHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const StepHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Text(
            title,
            style: AppTextStyles.font20W800White()
                .copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        if (subtitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p16),
            child: Text(subtitle, style: AppTextStyles.font16W500White()),
          ),
      ],
    );
  }
}
