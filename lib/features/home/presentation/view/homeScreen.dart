import 'package:flutter/material.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/utils/color_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: CustomAppBar(title: "Home"),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          CustomTextField(hint: "Email",controller:TextEditingController(),)
        ],),
      )
      ,);
  }
}

