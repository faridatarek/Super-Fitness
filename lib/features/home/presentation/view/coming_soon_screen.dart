import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.mainLayout);
                    },
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: ColorManager.primary,
                      child: SvgPicture.asset(
                        SVGAssets.arrowIcon,
                        width: 15.w,
                        height: 15.h,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.construction,
                size: 100,
                color: ColorManager.primary,
              ),
              const SizedBox(height: 24),
              Text(
                StringsManager.thisFeatureIsComingSoon.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.font24W800White(
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                StringsManager.stayTuned.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.font16W500White().copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
