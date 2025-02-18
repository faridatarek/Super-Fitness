import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness/utils/color_manager.dart';

class CustomBlurContainer extends StatelessWidget {
  final Widget child;
  final double? blurStrength;
  final double? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomBlurContainer({
    super.key,
    required this.child,
    this.blurStrength,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurStrength ?? 20.0,
          sigmaY: blurStrength ?? 20.0,
        ),
        child: Padding(
          padding:padding ?? const EdgeInsets.all(0) ,
          child: child,
        ),
      ),
    );
  }
}
