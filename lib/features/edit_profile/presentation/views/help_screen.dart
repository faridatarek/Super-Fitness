import 'package:flutter/material.dart';
import 'package:super_fitness/core/common/contact_support.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart'; // if you have a custom appbar
import 'package:super_fitness/core/widgets/custom_scaffold.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundImage: ImageAssets.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            // _buildHelpItem(
            //   icon: Icons.play_circle_fill,
            //   title: 'How to Use the App',
            //   description:
            //       'Learn how to get started with workouts, tracking, and nutrition.',
            //   onTap: () {
            //     // Navigate to tutorial or show dialog
            //   },
            // ),
            CustomAppBar(
                title: 'Help & Support', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 20),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TroubleshootingScreen(),
                    ));
              },
            ),
            _buildHelpItem(
              icon: Icons.support_agent,
              title: 'Contact Support',
              description: 'Need help? Reach out to our support team.',
              onTap: () {
                contactSupport();
              },
            ),
            _buildHelpItem(
              icon: Icons.feedback,
              title: 'Send Feedback',
              description: 'Tell us what you love or what we can improve.',
              onTap: () {
                contactSupport();
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

class TroubleshootingScreen extends StatelessWidget {
  const TroubleshootingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CustomAppBar(
            title: 'Troubleshooting',
            onTap: () => Navigator.pop(context),
          ),
          Text(
            'Find solutions to common issues before contacting support.',
            style: AppTextStyles.font14W500BaseColor(),
          ),
          const SizedBox(height: 16),
          _buildTroubleshootingItem(
            title: "Videos Not Playing",
            steps: [
              "Update the app to the latest version.",
              "Switch to a stable Wi-Fi connection instead of mobile data.",
              "Restart the app.",
              "Check if your subscription is active (if required)."
            ],
          ),
          _buildTroubleshootingItem(
            title: "Can't Chat with AI Trainer",
            steps: [
              "Ensure you have a stable internet connection.",
              "Update the app to the latest version.",
              "Log out and log back in to refresh your account.",
              "If the issue persists, contact support for assistance."
            ],
          ),
          _buildTroubleshootingItem(
            title: "Issue Editing User Info",
            steps: [
              "Ensure you are connected to the internet.",
              "Make sure you are logged into your account.",
              "Restart the app and try again.",
              "If the problem continues, try logging out and logging back in.",
              "Contact support if the issue persists.",
            ],
          ),
          _buildTroubleshootingItem(
            title: "Issue Changing Password",
            steps: [
              "Ensure you are connected to the internet.",
              "Enter your current password correctly.",
              "Ensure your new password meets the app's security requirements (length, characters, etc.).",
              "Restart the app and try again.",
              "If the issue persists, reset your password via the 'Forgot Password' option.",
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => contactSupport(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.support_agent),
            label: Text(
              "Contact Support",
              style: AppTextStyles.font16W500White(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshootingItem({
    required String title,
    required List<String> steps,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: AppTextStyles.font16W500White().copyWith(
              color: ColorManager.black,
            ),
          ),
          children: steps
              .map((step) => ListTile(
                    leading: const Icon(Icons.check_circle,
                        color: Colors.green, size: 20),
                    title: Text(
                      step,
                      style: AppTextStyles.font14W500BaseColor(),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
