import 'package:flutter/material.dart';
import 'package:super_fitness/utils/assets_manager.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssets.backGround,
              fit: BoxFit.cover,
            ),
          ),
          body,
        ],
      ),
    );
  }
}
