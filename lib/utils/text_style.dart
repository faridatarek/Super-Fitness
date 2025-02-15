import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle font24W500White({
    Color? color = ColorManager.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.balooThambi2(
      textStyle: TextStyle(
        color: color ?? ColorManager.white,
        fontSize: fontSize ?? AppSize.s24,
        fontWeight: fontWeight,
      ),
    );
  }
  static TextStyle font18W400White({
    Color? color = ColorManager.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.balooThambi2(
      textStyle: TextStyle(
        color: color ?? ColorManager.white,
        fontSize: fontSize ?? AppSize.s18,
        fontWeight: fontWeight,
      ),
    );
  }
  static TextStyle font24W800White({
    Color? color = ColorManager.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.balooThambi2(
      textStyle: TextStyle(
        color: color ?? ColorManager.white,
        fontSize: fontSize ?? AppSize.s24,
        fontWeight: fontWeight,
      ),
    );
  }
  static TextStyle font20W800White({
    Color? color = ColorManager.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.balooThambi2(
      textStyle: TextStyle(
        color: color ?? ColorManager.white,
        fontSize: fontSize ?? AppSize.s20,
        fontWeight: fontWeight,
      ),
    );
  }
  static TextStyle font14W800White({
    Color? color = ColorManager.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.balooThambi2(
      textStyle: TextStyle(
        color: color ?? ColorManager.white,
        fontSize: fontSize ?? AppSize.s14,
        fontWeight: fontWeight,
      ),
    );
  }
  // Title Text Style
  static TextStyle titleFont24W600({
    Color? color = ColorManager.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.balooThambi2(
      textStyle: TextStyle(
        color: color ?? ColorManager.white,
        fontSize: fontSize ?? AppSize.s24,
        fontWeight: fontWeight,
      ),
    );
  }

}
