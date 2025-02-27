import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/features/profile/presentation/widgets/options_lsit.dart';
import 'package:super_fitness/utils/color_manager.dart';

class OptionsContainer extends StatelessWidget {
  const OptionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 430.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.grey2,
        ),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) => optionsList[index],
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
            itemCount: optionsList.length),
      ),
    );
  }
}
