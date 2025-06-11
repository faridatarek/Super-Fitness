import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/values_manager.dart';
import 'package:wheel_slider/wheel_slider.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class NumberSelector extends StatelessWidget {
  final int min;
  final int max;
  final String labelText;
  final Color selectedColor;
  final Color unselectedColor;
  final void Function(int selectedValue)? onNextPressed;
  final String buttonText;
  const NumberSelector({
    Key? key,
    required this.min,
    required this.max,
    required this.labelText,
    this.selectedColor = Colors.deepOrange,
    this.unselectedColor = Colors.white,
    this.onNextPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NumberSelectorProvider>(context);

    return Center(
      child: BackgroundContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSize.s20.h),
              Text(labelText, style: AppTextStyles.font12W300Primary()),
              SizedBox(height: AppSize.s20.h),

              // WheelSlider instead of ListView
              WheelSlider.number(
                itemSize: AppSize.s60.w,
                perspective: 0.003,
                listWidth: AppSize.s200.w,
                initValue: provider.selectedNumber,
                totalCount: max,
                unSelectedNumberStyle: AppTextStyles.font33W900White(),
                selectedNumberStyle:
                    AppTextStyles.font33W900White(color: selectedColor),
                onValueChanged: (value) {
                  provider.selectNumber(value);
                },
                currentIndex: provider.selectedNumber,
              ),

              SizedBox(height: AppSize.s10.h),
              SvgPicture.asset(
                'assets/svg/triangle.svg',
                height: AppSize.s10.h,
              ),
              SizedBox(height: AppSize.s20.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: CustomButton(
                  onPressed: () => onNextPressed?.call(provider.selectedNumber),
                  text: buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberSelectorProvider extends ChangeNotifier {
  int selectedNumber;

  NumberSelectorProvider({required int initialValue})
      : selectedNumber = initialValue;

  void selectNumber(int number) {
    selectedNumber = number;
    notifyListeners();
  }
}
