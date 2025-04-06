import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/social_login_widget.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class InitialStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RegisterCubit cubit;

  const InitialStep({super.key, required this.formKey, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Text(StringsManager.heyThere,
                    style: AppTextStyles.font18W400White()
                        .copyWith(fontSize: AppSize.s18.sp)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Text(StringsManager.createAnAccount,
                    style: AppTextStyles.font20W800White()
                        .copyWith(fontSize: AppSize.s20.sp)),
              ),
            ),
            BackgroundContainer(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(StringsManager.register,
                          style: AppTextStyles.font24W800White()
                              .copyWith(fontSize: AppSize.s24.sp)),
                      SizedBox(height: AppSize.s16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          child: SvgPicture.asset(
                            SVGAssets.user,
                            width: AppSize.s24,
                            height: AppSize.s24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        hint: StringsManager.firstName,
                        controller: cubit.firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.pleaseEnterYourFirstName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          child: SvgPicture.asset(
                            SVGAssets.user,
                            width: AppSize.s24,
                            height: AppSize.s24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        hint: StringsManager.lastName,
                        controller: cubit.lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.pleaseEnterYourLastName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          child: SvgPicture.asset(
                            SVGAssets.mail,
                            width: AppSize.s24,
                            height: AppSize.s24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        hint: StringsManager.email,
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.pleaseEnterYourEmail;
                          }
                          if (!value.contains('@')) {
                            return StringsManager.pleaseEnterValidEmail;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          child: SvgPicture.asset(
                            SVGAssets.lock,
                            width: AppSize.s24,
                            height: AppSize.s24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        hint: StringsManager.password,
                        controller: cubit.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.pleaseEnterYourPassword;
                          }
                          if (value.length < 6) {
                            return StringsManager.passwordMustBeAtLeast6Chars;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          child: SvgPicture.asset(
                            SVGAssets.lock,
                            width: AppSize.s24,
                            height: AppSize.s24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        hint: StringsManager.rePassword,
                        controller: cubit.rePasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.pleaseReEnterYourPassword;
                          }
                          if (value != cubit.passwordController.text) {
                            return StringsManager.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s24.h),
                      SocialLoginWidget(),
                      CustomButton(
                        text: StringsManager.register,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateUserData(
                                'firstName', cubit.firstNameController.text);
                            cubit.updateUserData(
                                'lastName', cubit.lastNameController.text);
                            cubit.updateUserData(
                                'email', cubit.emailController.text);
                            cubit.updateUserData(
                                'password', cubit.passwordController.text);
                            cubit.updateUserData(
                                'rePassword', cubit.rePasswordController.text);
                            cubit.nextStep();
                          }
                        },
                      ),
                      SizedBox(height: AppSize.s8.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: StringsManager.alreadyHaveAnAccount,
                              style: AppTextStyles.font14W800White()
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                                text: StringsManager.login,
                                style: AppTextStyles.font16W500White()
                                    .copyWith(color: Colors.orange)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
