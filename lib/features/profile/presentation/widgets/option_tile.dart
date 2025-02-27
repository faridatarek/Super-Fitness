import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/utils/color_manager.dart';

class OptionTile extends StatelessWidget {
  final String svgPath;
  final String title;
  const OptionTile({super.key, required this.svgPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(svgPath),
      title: Text(
        title,
        style: TextStyle(
            color: title == "Logout" ? ColorManager.primary : Colors.white,
            fontWeight: FontWeight.w600),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: ColorManager.primary,
      ),
    );
  }
}
