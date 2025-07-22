import 'package:flutter/material.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart'; // if you have a custom appbar
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Help & Support', onTap: () => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHelpItem(
              icon: Icons.play_circle_fill,
              title: 'How to Use the App',
              description:
                  'Learn how to get started with workouts, tracking, and nutrition.',
              onTap: () {
                // Navigate to tutorial or show dialog
              },
            ),
            _buildHelpItem(
              icon: Icons.question_answer,
              title: 'Frequently Asked Questions',
              description:
                  'Answers to the most common questions about the app.',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.FAQScreen);
              },
            ),
            _buildHelpItem(
              icon: Icons.bug_report,
              title: 'Troubleshooting',
              description:
                  'Fix issues related to login, videos, or notifications.',
              onTap: () {
                // Navigate or show details
              },
            ),
            _buildHelpItem(
              icon: Icons.support_agent,
              title: 'Contact Support',
              description: 'Need help? Reach out to our support team.',
              onTap: () {
                // Show support email or open chat
              },
            ),
            _buildHelpItem(
              icon: Icons.feedback,
              title: 'Send Feedback',
              description: 'Tell us what you love or what we can improve.',
              onTap: () {
                // Feedback screen or dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 32, color: ColorManager.primary),
        title: Text(title,
            style: AppTextStyles.font16W500White().copyWith(
              color: ColorManager.black,
            )),
        subtitle: Text(description, style: AppTextStyles.font14W500BaseColor()),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
