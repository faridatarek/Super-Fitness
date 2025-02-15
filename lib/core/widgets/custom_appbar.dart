import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';


PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: AppTextStyles.titleFont24W600(),
    ),
    leading: CircleAvatar(
      radius: 25.r,
      backgroundColor: ColorManager.primary,
      child: SvgPicture.asset(SVGAssets.arrowIcon),
    ),
  );
}
