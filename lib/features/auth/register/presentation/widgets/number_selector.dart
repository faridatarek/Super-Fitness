import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';

class NumberSelector extends StatefulWidget {
  final int min;
  final int max;
  final String labelText;
  final Color selectedColor;
  final Color unselectedColor;
  final void Function(int selectedValue)? onNextPressed; // Updated here

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
  _NumberSelectorState createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late int selectedNumber;
  final ScrollController _scrollController = ScrollController();
  late List<int> numbers;

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.min;
    numbers = List.generate(widget.max - widget.min + 1, (i) => i + widget.min);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Text(
              widget.labelText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  final number = numbers[index];
                  final isSelected = number == selectedNumber;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = number;
                      });
                      // Animate to center the selected number
                      _scrollController.animateTo(
                        (index * 60.0) -
                            (MediaQuery.of(context).size.width / 2) +
                            30,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            number.toString(),
                            style: TextStyle(
                              color: isSelected
                                  ? widget.selectedColor
                                  : widget.unselectedColor,
                              fontSize: isSelected ? 24 : 20,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.text_rotation_angleup_sharp,
                              size: 12,
                              color: widget.selectedColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onNextPressed != null) {
                    widget.onNextPressed!(
                        selectedNumber); // Pass selected number here
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.selectedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
