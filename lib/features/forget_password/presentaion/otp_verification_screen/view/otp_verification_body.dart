import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:super_fitness/features/forget_password/domain/data_intent/data_intent.dart';
import 'package:super_fitness/features/forget_password/presentaion/otp_verification_screen/view_model/reset_code_view_model.dart';

import '../../../../../core/widgets/custom_blur_continer.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/color_manager.dart';
import '../../../../../utils/strings_manager.dart';
import '../../../../../utils/text_style.dart';

class OtpVerificationBody extends StatelessWidget {
  const OtpVerificationBody({super.key, required this.viewModel});
  final OtpVerifyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Center(child: Image.asset(ImageAssets.logo, height: 80)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              StringsManager.otpCode.tr(),
              style: AppTextStyles.font14W800White(fontSize: 20),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              StringsManager.enterYourOtp.tr(),
              style: AppTextStyles.font18W400White(),
            ),
          ),
          const SizedBox(height: 20),
          CustomBlurContainer(
            blurStrength: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Pinput(
                  length: 6,
                  showCursor: true,
                  controller: viewModel.otpController,
                  onCompleted: (otp) {
                    viewModel.resetCode();
                    viewModel.clearOtp();
                  },
                  enabled: true,
                  autofocus: true,
                  defaultPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    textStyle: AppTextStyles.font24W500White(
                      fontSize: 20,
                      color: ColorManager.primary,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    textStyle: AppTextStyles.font24W500White(
                      fontSize: 20,
                      color: ColorManager.primary,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: ColorManager.primary, width: 2),
                      ),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    textStyle: AppTextStyles.font24W500White(
                      fontSize: 20,
                      color: ColorManager.primary,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: ColorManager.primary, width: 3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: CustomButton(
                    onPressed: () {},
                    text: StringsManager.confirm.tr(),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  StringsManager.didntReceiveCode.tr(),
                  style: AppTextStyles.font18W400White(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => viewModel.forgetPassword(
                      ForgotPasswordRequest(email: DataIntent.getUserMail()!)),
                  child: Text(
                    StringsManager.resendCode.tr(),
                    style: AppTextStyles.font20W800White(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primary,
                    ),
                  ),
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
