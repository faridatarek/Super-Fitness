import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';


PreferredSizeWidget CustomAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: AppTextStyles.titleFont24W600(),
    ),
    leading: CircleAvatar(
      radius: 18.r,
      backgroundColor: ColorManager.primary,
      child: SvgPicture.asset(SVGAssets.arrowIcon,width: 30.w,height: 30.h,),
    ),
  );
}
