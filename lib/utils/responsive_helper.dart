import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  final Size _size;

  ResponsiveHelper(this.context) : _size = MediaQuery.of(context).size;

  double w(double fraction) => _size.width * fraction;

  double h(double fraction) => _size.height * fraction;

  double sp(double fraction) => _size.width * fraction;

  static ResponsiveHelper of(BuildContext context) {
    return ResponsiveHelper(context);
  }

  double getResposiveTextSize(BuildContext context, double fontSize) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontSize = fontSize * scaleFactor;
    double lowerLimit = fontSize * 0.8;
    double upperLimit = fontSize * 1.2;
    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  double getScaleFactor(BuildContext context) {
    return MediaQuery.of(context).size.width / 400;
  }
}
