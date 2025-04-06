import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness/utils/values_manager.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppSize.s10, sigmaY: AppSize.s10),
        child: Container(
          decoration: BoxDecoration(
            color:
                Color(0xFF242424).withOpacity(0.1), // Adjust opacity as needed
          ),
          child: child,
        ),
      ),
    );
  }
}
