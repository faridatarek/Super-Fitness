import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_scaffold.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: ColorManager.primary,
                    child: SvgPicture.asset(
                      SVGAssets.arrowIcon,
                      width: 15.w,
                      height: 15.h,
                    ),
                  ),
                ),
              ),
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
              StringsManager.whatIsYourWeight.tr(),
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
              StringsManager.weightPersonalizedPlan.tr(),
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
            labelText: StringsManager.kg.tr(),
            onNextPressed: (selectedValue) {
              Navigator.pop(context, '$selectedValue kg');
            },
            buttonText: StringsManager.done.tr(),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalSelector(BuildContext context) {
    final List<String> goals = [
      StringsManager.gainWeight.tr(),
      StringsManager.loseWeight.tr(),
      StringsManager.getFitter.tr(),
      StringsManager.gainMoreFlexible.tr(),
      StringsManager.learnTheBasic.tr()
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.whatIsYourGoal.tr(),
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
              StringsManager.goalPersonalizedPlan.tr(),
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
      StringsManager.rookie.tr(): 'Rookie',
      StringsManager.beginner.tr(): 'Beginner',
      StringsManager.intermediate.tr(): 'Intermediate',
      StringsManager.advance.tr(): 'Advance',
      StringsManager.trueBeast.tr(): 'True Beast',
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.yourRegularActivityLevel.tr(),
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
