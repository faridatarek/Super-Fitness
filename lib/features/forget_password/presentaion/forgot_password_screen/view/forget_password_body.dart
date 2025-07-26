import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:super_fitness/features/forget_password/presentaion/forgot_password_screen/view_model/foget_password_view_model.dart';
import '../../../../../core/widgets/custom_blur_continer.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/strings_manager.dart';
import '../../../../../utils/text_style.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key, required this.viewModel});
  final ForgetPassWordViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundImage: ImageAssets.forgetPassBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Center(child: Image.asset(ImageAssets.logo, height: 70)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              StringsManager.enterYourEmail.tr(),
              style: AppTextStyles.font18W400White(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              StringsManager.forgetPassword.tr(),
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
                  controller: viewModel.forgetPassWordTextField,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: StringsManager.sendOtp.tr(),
                  onPressed: () {
                    viewModel.forgetPassWord(ForgotPasswordRequest(
                        email: viewModel.forgetPassWordTextField.text));
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
