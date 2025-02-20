import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';

class GenderSelection extends StatelessWidget {
  final void Function()? onNextPressed;
  final void Function(String gender)? onGenderSelected;

  const GenderSelection({super.key, this.onNextPressed, this.onGenderSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<GenderProvider>(
      builder: (context, genderProvider, _) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select Gender',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      genderProvider.setGender('male');
                      if (onGenderSelected != null) {
                        onGenderSelected!('male');
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: genderProvider.selectedGender == 'male'
                            ? Colors.deepOrange
                            : Colors.white24,
                      ),
                      child: const Icon(
                        Icons.male,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Male',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      genderProvider.setGender('female');
                      if (onGenderSelected != null) {
                        onGenderSelected!('female');
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: genderProvider.selectedGender == 'female'
                            ? Colors.deepOrange
                            : Colors.white24,
                      ),
                      child: const Icon(
                        Icons.female,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Female',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 60),
                  if (genderProvider.selectedGender != null)
                    CustomButton(
                      text: 'Next',
                      onPressed: () {
                        // Use the selected gender when pressing Next
                        if (onNextPressed != null) {
                          onNextPressed!();
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
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
