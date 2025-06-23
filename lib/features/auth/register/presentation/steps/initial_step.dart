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
            Align(alignment: Alignment.topLeft, child: _buildHeader()),
            _buildRegistrationForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Text(
            StringsManager.heyThere,
            style: AppTextStyles.font18W400White(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Text(
            StringsManager.createAnAccount,
            style: AppTextStyles.font20W800White(),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return BackgroundContainer(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                StringsManager.register,
                style: AppTextStyles.font24W800White(),
              ),
              SizedBox(height: AppSize.s16.h),
              _buildFormFields(),
              SizedBox(height: AppSize.s24.h),
              const SocialLoginWidget(),
              _buildRegisterButton(),
              SizedBox(height: AppSize.s8.h),
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildNameField(
          controller: cubit.firstNameController,
          hint: StringsManager.firstName,
          validator: _validateName,
        ),
        SizedBox(height: AppSize.s16.h),
        _buildNameField(
          controller: cubit.lastNameController,
          hint: StringsManager.lastName,
          validator: _validateName,
        ),
        SizedBox(height: AppSize.s16.h),
        _buildEmailField(),
        SizedBox(height: AppSize.s16.h),
        _buildPasswordField(
          controller: cubit.passwordController,
          hint: StringsManager.password,
          validator: _validatePassword,
        ),
        SizedBox(height: AppSize.s16.h),
        _buildPasswordField(
          controller: cubit.rePasswordController,
          hint: StringsManager.rePassword,
          validator: (value) =>
              _validateRePassword(value, cubit.passwordController.text),
        ),
      ],
    );
  }

  Widget _buildNameField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return CustomTextField(
      prefixIcon: _buildIcon(SVGAssets.user),
      hint: hint,
      controller: controller,
      validator: validator,
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      prefixIcon: _buildIcon(SVGAssets.mail),
      hint: StringsManager.email,
      controller: cubit.emailController,
      validator: _validateEmail,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return CustomTextField(
      prefixIcon: _buildIcon(SVGAssets.lock),
      hint: hint,
      controller: controller,
      obscureText: true,
      validator: validator,
    );
  }

  Widget _buildIcon(String asset) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: SvgPicture.asset(
        asset,
        width: AppSize.s24,
        height: AppSize.s24,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return CustomButton(
      text: StringsManager.register,
      onPressed: _handleRegistration,
    );
  }

  Widget _buildLoginPrompt() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: StringsManager.alreadyHaveAnAccount,
            style: AppTextStyles.font14W800White()
                .copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: StringsManager.login,
            style:
                AppTextStyles.font16W500White().copyWith(color: Colors.orange),
          ),
        ],
      ),
    );
  }

  void _handleRegistration() {
    if (formKey.currentState!.validate()) {
      cubit.updateUserData('firstName', cubit.firstNameController.text);
      cubit.updateUserData('lastName', cubit.lastNameController.text);
      cubit.updateUserData('email', cubit.emailController.text);
      cubit.updateUserData('password', cubit.passwordController.text);
      cubit.updateUserData('rePassword', cubit.rePasswordController.text);
      cubit.nextStep();
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return value == cubit.firstNameController.text
          ? StringsManager.pleaseEnterYourFirstName
          : StringsManager.pleaseEnterYourLastName;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringsManager.pleaseEnterYourEmail;
    }
    if (!value.contains('@')) {
      return StringsManager.pleaseEnterValidEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringsManager.pleaseEnterYourPassword;
    }
    if (value.length < 6) {
      return StringsManager.passwordMustBeAtLeast6Chars;
    }
    return null;
  }

  String? _validateRePassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return StringsManager.pleaseReEnterYourPassword;
    }
    if (value != password) {
      return StringsManager.passwordsDoNotMatch;
    }
    return null;
  }
}
