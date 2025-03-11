import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28.0),
        child: Container(
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2), // Dark background
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 1.5), // White border
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600, // Slightly bolder
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    color: isSelected
                        ? Colors.white
                        : Colors.transparent, // Fill circle if selected
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
