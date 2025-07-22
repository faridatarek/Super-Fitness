import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_scaffold.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/values_manager.dart';

enum EditType { weight, goal, activityLevel }

class EditComponent extends StatelessWidget {
  final EditType type;
  final String currentValue;

  const EditComponent({
    super.key,
    required this.type,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundImage: ImageAssets.forgetPassBackground,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageAssets.logo,
              height: AppSize.s48.h,
            ),
            const Spacer(),
            if (type == EditType.weight) _buildWeightSelector(context),
            if (type == EditType.goal) _buildGoalSelector(context),
            if (type == EditType.activityLevel)
              _buildActivityLevelSelector(context),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightSelector(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.whatIsYourWeight,
              style: AppTextStyles.font20W800White()
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.weightPersonalizedPlan,
              style: AppTextStyles.font16W500White(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NumberSelectorProvider(
              initialValue: int.tryParse(currentValue.split(' ')[0]) ?? 30),
          child: NumberSelector(
            min: 30,
            max: 150,
            labelText: StringsManager.kg,
            onNextPressed: (selectedValue) {
              Navigator.pop(context, '$selectedValue kg');
            },
            buttonText: StringsManager.done,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalSelector(BuildContext context) {
    final List<String> goals = [
      StringsManager.gainWeight,
      StringsManager.loseWeight,
      StringsManager.getFitter,
      StringsManager.gainMoreFlexible,
      StringsManager.learnTheBasic
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.whatIsYourGoal,
              style: AppTextStyles.font20W800White()
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.goalPersonalizedPlan,
              style: AppTextStyles.font16W500White(),
            ),
          ),
        ),
        SizedBox(height: AppSize.s16.h),
        ChangeNotifierProvider(
          create: (_) => GoalsProvider(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6.h,
            child: GoalsScreen(
              items: goals,
              onNext: (selectedValue) {
                Navigator.pop(context, selectedValue);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityLevelSelector(BuildContext context) {
    final Map<String, String> levelMap = {
      StringsManager.rookie: 'Rookie',
      StringsManager.beginner: 'Beginner',
      StringsManager.intermediate: 'Intermediate',
      StringsManager.advance: 'Advance',
      StringsManager.trueBeast: 'True Beast',
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.yourRegularActivityLevel,
              style: AppTextStyles.font20W800White()
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ),
        SizedBox(height: AppSize.s16.h),
        ChangeNotifierProvider(
          create: (_) => GoalsProvider(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6.h,
            child: GoalsScreen(
              items: levelMap.keys.toList(),
              onNext: (selectedValue) {
                Navigator.pop(context, levelMap[selectedValue] ?? 'Rookie');
              },
            ),
          ),
        ),
      ],
    );
  }
}
