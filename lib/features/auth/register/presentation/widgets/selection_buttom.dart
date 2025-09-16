import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/values_manager.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showRadio;

  const SelectionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.showRadio = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s28),
        child: Container(
          height: AppSize.s50.h,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2), // Dark background
            borderRadius: BorderRadius.circular(AppSize.s28),
            border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: AppSize.s1_5), // White border
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p20),
                  child: Text(text,
                      style: AppTextStyles.font12W300Primary(
                          color: ColorManager.white,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              if (showRadio)
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p16),
                  child: Container(
                    width: AppSize.s24.w,
                    height: AppSize.s24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Colors.white, width: AppSize.s2),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: isSelected
                          ? Container(
                              width: AppSize.s12,
                              height: AppSize.s12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
