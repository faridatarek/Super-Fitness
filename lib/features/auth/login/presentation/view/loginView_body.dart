import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/features/auth/login/presentation/view/login_validator/login_validator_types_enum.dart';
import 'package:super_fitness/features/auth/login/presentation/viewModel/login_viewModel.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

import '../../../../../utils/assets_manager.dart';

class LoginViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<LoginViewModel>(context);
    final loginValidator = viewModel.loginValidator;

    void login() {
      viewModel.handleIntent(LoginIntent(
        email: loginValidator.emailController.text,
        password: loginValidator.passwordController.text,
      ));
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              '${PNGAssets.background1}',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 50.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(PNGAssets.logo),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 190.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.heyThere.tr(),
                  style: AppTextStyles.font18W400White(),
                ),
                Text(
                  StringsManager.welcomeBack.tr(),
                  style: AppTextStyles.font20W800White(),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 100.h,
            ),
            child: Center(
              child: BackgroundContainer(
                child: Container(
                  height: 450.h,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Form(
                    key: loginValidator.loginFormKey,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: viewModel.fieldsFilledNotifier,
                      builder: (context, areAllFieldsFilled, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              StringsManager.login.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Email Field
                            CustomTextField(
                              hint: StringsManager.email.tr(),
                              controller: loginValidator.emailController,
                              validator: loginValidator
                                  .validate(LoginValidatorTypesEnum.email),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: ColorManager.white,
                              ),
                            ),
                            SizedBox(height: 20.h),

                            CustomTextField(
                              hint: StringsManager.password.tr(),
                              controller: loginValidator.passwordController,
                              validator: loginValidator
                                  .validate(LoginValidatorTypesEnum.password),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: ColorManager.white,
                              ),
                              obscureText: true,
                            ),

                            Row(
                              children: [
                                Spacer(),
                                TextButton(
                                  child: Text(
                                    "Forget Password?",
                                    style: AppTextStyles.font14W500BaseColor(),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.forgetPasswordScreen);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),

                            BlocBuilder<LoginViewModel, BaseState>(
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return const CircularProgressIndicator();
                                }
                                return CustomButton(
                                  text: StringsManager.login.tr(),
                                  color: areAllFieldsFilled
                                      ? ColorManager.primary
                                      : Colors.grey,
                                  onPressed: areAllFieldsFilled ? login : null,
                                );
                              },
                            ),
                            SizedBox(height: 15.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  StringsManager.alreadyHaveAccount.tr(),
                                  style: AppTextStyles.font18W400White(
                                      fontSize: 14.sp),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.registerScreen);
                                  },
                                  child: Text(
                                    StringsManager.register.tr(),
                                    style: AppTextStyles.font14W800White(
                                        color: ColorManager.primary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
