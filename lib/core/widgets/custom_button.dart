import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final Color? fontColor;
  final double fontSize;
  final double? radius;
  const CustomButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.color,
      this.width = double.infinity,
      this.height = 40,
      this.fontSize = 14,
      this.fontColor,
      this.radius});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width.w, height.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 100.r),
        ),
        disabledBackgroundColor: color ?? ColorManager.primary,
        backgroundColor: color ?? ColorManager.primary,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.font14W800White(),
      ),
    );
  }
}
