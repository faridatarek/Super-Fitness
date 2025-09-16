import 'package:flutter/material.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/core/widgets/custom_scaffold.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How do I start a workout?',
      'answer':
          'Go to the Home screen and choose one of the recommended workouts or browse categories.'
    },
    {
      'question': 'Can I track my progress?',
      'answer':
          'Yes! Head to the Progress tab to see your completed workouts and achievements.'
    },
    {
      'question': 'How do I reset my password?',
      'answer': 'Go to Profile > Settings > Change Password to reset it.'
    },
    {
      'question': 'Is there a way to contact a trainer?',
      'answer':
          'Currently, we offer pre-recorded sessions, but live coaching is coming soon!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundImage: ImageAssets.backGround,
      body: Column(
        children: [
          CustomAppBar(title: 'FAQs', onTap: () => Navigator.pop(context)),
          Expanded(
            child: ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Theme(
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          faq['question']!,
                          style: AppTextStyles.font16W500White().copyWith(
                            color: ColorManager
                                .black, // same as troubleshooting style
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              faq['answer']!,
                              style: AppTextStyles.font14W500BaseColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
