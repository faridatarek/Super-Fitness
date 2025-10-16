import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/selection_buttom.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/values_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';

class GoalsScreen extends StatelessWidget {
  final List<String> items;
  final void Function(String selectedValue) onNext;

  const GoalsScreen({
    super.key,
    required this.items,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = screenWidth < 350
              ? 8.w
              : AppPadding.p16.w; // adjust for narrow screens
          double verticalPadding = screenHeight < 600 ? 6.h : AppPadding.p8.h;

          return Consumer<GoalsProvider>(
            builder: (context, goalsProvider, _) {
              return Column(
                children: [
                  Expanded(
                    child: BackgroundContainer(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child: Scrollbar(
                          thumbVisibility: true,
                          radius: Radius.circular(12.r),
                          thickness: 4.w,
                          interactive: true,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: items
                                      .map(
                                        (item) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.h),
                                          child: SelectionButton(
                                            text: item,
                                            isSelected:
                                                goalsProvider.selectedItem ==
                                                    item,
                                            onTap: () =>
                                                goalsProvider.selectItem(item),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(height: AppSize.s20.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPadding),
                                  child: CustomButton(
                                    onPressed: goalsProvider.selectedItem !=
                                            null
                                        ? () =>
                                            onNext(goalsProvider.selectedItem!)
                                        : null,
                                    text: StringsManager.next.tr(),
                                  ),
                                ),
                                SizedBox(height: AppSize.s12.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s10.h),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class GoalsProvider with ChangeNotifier {
  String? _selectedItem;

  String? get selectedItem => _selectedItem;

  void selectItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}
