import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:super_fitness/core/widgets/custom_scaffold.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

import '../../../../core/widgets/custom_blur_continer.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';


import '../../../../utils/strings_manager.dart';
import '../../otp_verification_screen/view/otp_verification_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              StringsManager.enterYourEmail,
              style: AppTextStyles.font18W400White(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              StringsManager.forgetPassword,
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
                  hint: StringsManager.emailHint,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: StringsManager.sendOtp,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpVerificationScreen(),
                      ),
                    );
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

