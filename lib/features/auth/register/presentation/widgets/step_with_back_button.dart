import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/progress_arc.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class StepWithBackButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onBackPressed;
  final int currentStepIndex;
  final int totalSteps;

  const StepWithBackButton({
    super.key,
    required this.child,
    required this.onBackPressed,
    required this.currentStepIndex,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppSize.s16.h, left: AppSize.s16.w),
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: onBackPressed,
              child: CircleAvatar(
                radius: AppSize.s18.r,
                backgroundColor: ColorManager.primary,
                child: SvgPicture.asset(
                  SVGAssets.arrowIcon,
                  width: AppSize.s18.w,
                  height: AppSize.s18.h,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        if (currentStepIndex > 0)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppSize.s16.h),
                child: ProgressArc(
                  current: currentStepIndex,
                  total: totalSteps,
                ),
              ),
              SizedBox(height: AppSize.s24.h),
              child,
            ],
          ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
