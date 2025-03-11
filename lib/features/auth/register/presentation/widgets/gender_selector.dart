import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';

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
              width: double.infinity, // Ensure widget fills screen width
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Male Selection
                    GestureDetector(
                      onTap: () {
                        genderProvider.setGender('male');
                        onGenderSelected?.call('male');
                      },
                      child: CircleGenderOption(
                        icon: Icons.male,
                        label: 'Male',
                        isSelected: genderProvider.selectedGender == 'male',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Female Selection
                    GestureDetector(
                      onTap: () {
                        genderProvider.setGender('female');
                        onGenderSelected?.call('female');
                      },
                      child: CircleGenderOption(
                        icon: Icons.female,
                        label: 'Female',
                        isSelected: genderProvider.selectedGender == 'female',
                      ),
                    ),
                    const SizedBox(height: 60),

                    // "Next" Button (Only shown after selection)
                    if (genderProvider.selectedGender != null)
                      SizedBox(
                        width: double.infinity, // Ensure full-width button
                        child: CustomButton(
                          text: 'Next',
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

// Keeps gender selection buttons as circular
class CircleGenderOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const CircleGenderOption({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.deepOrange : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.deepOrange : Colors.white,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
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
