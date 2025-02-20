import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/selection_buttom.dart';

class GoalsScreen extends StatelessWidget {
  final List<String> items;
  final void Function(String selectedValue) onNext; // Updated here

  const GoalsScreen({Key? key, required this.items, required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GoalsProvider>(
        builder: (context, goalsProvider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return SelectionButton(
                      text: item,
                      isSelected: goalsProvider.selectedItem == item,
                      onTap: () => goalsProvider.selectItem(item),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  onPressed: goalsProvider.selectedItem != null
                      ? () => onNext(goalsProvider.selectedItem!)
                      : null,
                  text: 'Next',
                ),
              ),
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
