import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/selection_buttom.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class GoalsScreen extends StatelessWidget {
  final List<String> items;
  final void Function(String selectedValue) onNext;

  const GoalsScreen({Key? key, required this.items, required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GoalsProvider>(
        builder: (context, goalsProvider, _) {
          return Column(
            children: [
              BackgroundContainer(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: items.map((item) {
                          return SelectionButton(
                            text: item,
                            isSelected: goalsProvider.selectedItem == item,
                            onTap: () => goalsProvider.selectItem(item),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSize.s20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p16),
                        child: CustomButton(
                          onPressed: goalsProvider.selectedItem != null
                              ? () => onNext(goalsProvider.selectedItem!)
                              : null,
                          text: StringsManager.next,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer()
            ],
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
