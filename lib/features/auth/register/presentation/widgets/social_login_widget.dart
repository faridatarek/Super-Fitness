import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: AppPadding.p40),
                child: Divider(color: Colors.white, thickness: AppSize.s1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Text(
                StringsManager.or.tr(),
                style:
                    const TextStyle(color: Colors.white, fontSize: AppSize.s16),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: AppPadding.p40),
                child: Divider(color: Colors.white, thickness: AppSize.s1),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(SVGAssets.facebookCircle),
            const SizedBox(width: AppSize.s16),
            _buildSocialButton(SVGAssets.googleCircle),
            const SizedBox(width: AppSize.s16),
            _buildSocialButton(SVGAssets.appleCircle),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(String assetName) {
    return SizedBox(
      width: AppSize.s50,
      height: AppSize.s50,
      child: Center(
        child: SvgPicture.asset(
          assetName,
          width: AppSize.s32,
        ),
      ),
    );
  }
}
