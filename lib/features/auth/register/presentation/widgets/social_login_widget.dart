import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Divider(color: Colors.white, thickness: 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Or",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Divider(color: Colors.white, thickness: 1),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton("assets/svg/facebook circle.svg"),
            const SizedBox(width: 16),
            _buildSocialButton("assets/svg/google circle.svg"),
            const SizedBox(width: 16),
            _buildSocialButton("assets/svg/apple circle.svg"),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(String assetName) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: SvgPicture.asset(
          assetName,
          width: 32,
        ),
      ),
    );
  }
}
