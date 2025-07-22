import 'package:flutter/material.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 100,
                color: ColorManager.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'This feature is\ncoming soon!',
                textAlign: TextAlign.center,
                style: AppTextStyles.font24W800White(
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We’re working hard to bring this to you.\nStay tuned for updates!',
                textAlign: TextAlign.center,
                style: AppTextStyles.font16W500White().copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
