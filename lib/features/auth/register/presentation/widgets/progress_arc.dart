import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/values_manager.dart';

class ProgressArc extends StatelessWidget {
  final int current;
  final int total;

  const ProgressArc({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    double progress = current / total;

    return CircularPercentIndicator(
      radius: AppSize.s20,
      lineWidth: AppSize.s5,
      percent: progress,
      center: Text(
        "$current/$total",
        style: AppTextStyles.font14W800White(),
      ),
      progressColor: ColorManager.primary,
      backgroundColor: Colors.transparent,
      circularStrokeCap: CircularStrokeCap.square,
      startAngle: AppSize.s180,
    );
  }
}
