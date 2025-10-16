import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity, // 👈 ensures full screen fit
        child: Stack(
          children: [
            // 🔹 Background image
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.editProfileBackground),
                    fit: BoxFit.cover, // 👈 fills whole screen
                  ),
                ),
              ),
            ),

            // 🔹 Blur overlay
            Positioned.fill(
              child: BackdropFilter(
                filter:
                    ImageFilter.blur(sigmaX: AppSize.s5, sigmaY: AppSize.s5),
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ),

            // 🔹 Scrollable content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAppBar(
                      title: StringsManager.profile.tr(),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.mainLayout,
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.s20),
                    Center(
                      child: ChangeNotifierProvider.value(
                        value: getIt<UserProvider>(),
                        child: const ProfileHeader(isEditable: false),
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    const ProfileMenu(),
                    const SizedBox(height: AppSize.s20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
