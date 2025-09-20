import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class GenderSelection extends StatelessWidget {
  final void Function()? onNextPressed;
  final void Function(String gender)? onGenderSelected;

  const GenderSelection({super.key, this.onNextPressed, this.onGenderSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<GenderProvider>(
      builder: (context, genderProvider, _) {
        return Center(
          child: BackgroundContainer(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Male Selection
                    GestureDetector(
                      onTap: () {
                        genderProvider
                            .setGender(StringsManager.male.toLowerCase().tr());
                        onGenderSelected
                            ?.call(StringsManager.male.toLowerCase().tr());
                      },
                      child: CircleGenderOption(
                        svgPath: SVGAssets.male,
                        label: StringsManager.male.tr(),
                        isSelected: genderProvider.selectedGender ==
                            StringsManager.male.toLowerCase().tr(),
                      ),
                    ),
                    const SizedBox(height: AppSize.s40),

                    // Female Selection
                    GestureDetector(
                      onTap: () {
                        genderProvider.setGender(
                            StringsManager.female.toLowerCase().tr());
                        onGenderSelected
                            ?.call(StringsManager.female.toLowerCase().tr());
                      },
                      child: CircleGenderOption(
                        svgPath: SVGAssets.female,
                        label: StringsManager.female.tr(),
                        isSelected: genderProvider.selectedGender ==
                            StringsManager.female.toLowerCase().tr(),
                      ),
                    ),
                    const SizedBox(height: AppSize.s60),

                    // "Next" Button (Only shown after selection)
                    if (genderProvider.selectedGender != null)
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: StringsManager.next.tr(),
                          onPressed: onNextPressed,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleGenderOption extends StatelessWidget {
  final String svgPath;
  final String label;
  final bool isSelected;

  const CircleGenderOption({
    super.key,
    required this.svgPath,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s100,
      height: AppSize.s100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.deepOrange : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.deepOrange : Colors.white,
          width: AppSize.s1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: AppSize.s30,
              height: AppSize.s30,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(height: AppSize.s4),
            Text(
              label,
              style: AppTextStyles.font14W800White(),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderProvider with ChangeNotifier {
  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  void setGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }
}
