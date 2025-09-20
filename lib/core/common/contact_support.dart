import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> contactSupport() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'mennaragab3330@gmail.com',
    query: Uri.encodeComponent(
      'subject=Super Fitness App Support&body=Hello,\n\nI need help with...',
    ),
  );

  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(
      emailLaunchUri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    debugPrint('Could not launch email client');
  }
}
