import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/widgets/validators.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/create_newpass_request.dart';
import '../../../../../core/widgets/custom_blur_continer.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/strings_manager.dart';
import '../../../../../utils/text_style.dart';
import '../view_model/create_new_password_view_model.dart';

class CreateNewPasswordBody extends StatelessWidget {
  CreateNewPasswordBody({super.key, required this.viewModel});
  final CreateNewPassWordViewModel viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundImage: ImageAssets.forgetPassBackground,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Center(child: Image.asset(ImageAssets.logo, height: 70)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                StringsManager.ensurePassWordText.tr(),
                style: AppTextStyles.font18W400White(),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                StringsManager.passWordText.tr(),
                style: AppTextStyles.font20W800White(),
              ),
            ),
            const SizedBox(height: 20),
            CustomBlurContainer(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: SvgPicture.asset(SVGAssets.mail),
                    hint: StringsManager.emailHint.tr(),
                    controller: viewModel.emailController,
                    validator: AppValidators.validateEmail,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: SvgPicture.asset(SVGAssets.lock),
                    hint: StringsManager.passwordHint.tr(),
                    controller: viewModel.passWordController,
                    obscureText: true,
                    validator: AppValidators.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: StringsManager.done.tr(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        viewModel.createNewPassWord(CreateNewPassWordRequest(
                            newPassword: viewModel.passWordController.text,
                            email: viewModel.emailController.text));
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
