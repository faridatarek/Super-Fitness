import 'package:flutter/material.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/profile_menu_item.dart';
import 'package:super_fitness/utils/color_manager.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.darkGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const MenuItemsList(),
      ),
    );
  }
}
