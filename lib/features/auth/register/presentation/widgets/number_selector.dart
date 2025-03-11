import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:wheel_slider/wheel_slider.dart';

class NumberSelector extends StatelessWidget {
  final int min;
  final int max;
  final String labelText;
  final Color selectedColor;
  final Color unselectedColor;
  final void Function(int selectedValue)? onNextPressed;

  const NumberSelector({
    Key? key,
    required this.min,
    required this.max,
    required this.labelText,
    this.selectedColor = Colors.deepOrange,
    this.unselectedColor = Colors.white,
    this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NumberSelectorProvider>(context);

    return Center(
      child: BackgroundContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(labelText, style: AppTextStyles.font12W300White()),
              SizedBox(height: 20.h),

              // WheelSlider instead of ListView
              WheelSlider.number(
                itemSize: 60.w,
                perspective: 0.005,
                listWidth: 200.w,
                initValue: provider.selectedNumber,
                totalCount: max,
                unSelectedNumberStyle: AppTextStyles.font33W900White(),
                selectedNumberStyle: AppTextStyles.font44W900Primary(),
                onValueChanged: (value) {
                  provider.selectNumber(value);
                },
                currentIndex: provider.selectedNumber,
              ),

              SizedBox(height: 10.h),
              SvgPicture.asset(
                'assets/svg/triangle.svg',
                height: 10.h,
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                  onPressed: () => onNextPressed?.call(provider.selectedNumber),
                  text: 'Next',
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
