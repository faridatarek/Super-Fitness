import 'package:flutter/material.dart';
import 'package:super_fitness/utils/color_manager.dart';

class ThemeManger {
  static ThemeData themeManger = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xffFF4100),
        primary: ColorManager.lightGrey,
        onError: Colors.red,
        secondary: const Color(0xffA6A6A6)),
    scaffoldBackgroundColor: ColorManager.grey,
    useMaterial3: true,
  );
}
