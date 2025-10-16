import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class StartchatView extends StatelessWidget {
  final userProvider = getIt<UserProvider>();
  StartchatView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(PNGAssets.chatBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.mainLayout, (route) => false),
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
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${StringsManager.hi}${userProvider.user?.firstName}",
                              style: AppTextStyles.font24W500White(
                                  fontSize: 18.sp),
                            ),
                            Text(
                              StringsManager.iAmYourSmartCoach.tr(),
                              style: AppTextStyles.font24W500White(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 35.w), // Balance the back button
                    ],
                  ),
                ),

                // Main content - takes remaining space
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Large image
                      Container(
                        height: screenHeight * 0.4, // 40% of screen height
                        width: screenWidth * 0.9, // 90% of screen width
                        child: Image.asset(
                          PNGAssets.startChat,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Bottom card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: CustomButton(
                          text: StringsManager.getStarted.tr(),
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, AppRoutes.ChatScreen),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
