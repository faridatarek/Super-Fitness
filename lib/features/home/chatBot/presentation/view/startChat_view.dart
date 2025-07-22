import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class StartchatView extends StatelessWidget {
  final userProvider = getIt<UserProvider>();
  StartchatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              '${PNGAssets.chatBackground}',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
                child: AppBar(
              title: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hi ,${userProvider.user?.firstName}",
                      style: AppTextStyles.font24W500White(fontSize: 18.sp),
                    ),
                    Text(
                      "I Am your smart coach",
                      style: AppTextStyles.font24W500White(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leadingWidth: 40.w,
              leading: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: InkWell(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.mainLayout, (route) => false),
                  child: CircleAvatar(
                    radius: 10.r,
                    backgroundColor: ColorManager.primary,
                    child: SvgPicture.asset(
                      SVGAssets.arrowIcon,
                      width: 15.w,
                      height: 15.h,
                    ),
                  ),
                ),
              ),
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                height: 450.h,
                PNGAssets.startChat,
              ),
              Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorManager.chatBotmessage.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(40.r)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("How Can I Assist You",
                          style: AppTextStyles.font24W800White(fontSize: 18)),
                      Text("Today ?",
                          style: AppTextStyles.font24W800White(fontSize: 18)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 20.h),
                        child: CustomButton(
                          text: "Get Started",
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, AppRoutes.ChatScreen),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
