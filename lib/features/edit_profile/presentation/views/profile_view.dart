import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/profile_header.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/profile_menu.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssets.editProfileBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: AppSize.s5, sigmaY: AppSize.s5),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: StringsManager.profile),
                Center(
                    child: ChangeNotifierProvider.value(
                        value: getIt<UserProvider>(),
                        child: const ProfileHeader(
                          isEditable: false,
                        ))),
                const SizedBox(height: AppSize.s20),
                const Spacer(flex: 1),
                const ProfileMenu(),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
