import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressArc extends StatelessWidget {
  final int current;
  final int total;

  const ProgressArc({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    double progress = current / total;

    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 10.0,
      percent: progress,
      center: Text(
        "$current/$total",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      progressColor: Colors.red,
      backgroundColor: Colors.transparent,
      circularStrokeCap: CircularStrokeCap.round,
      startAngle: 180,
    );
  }
}
