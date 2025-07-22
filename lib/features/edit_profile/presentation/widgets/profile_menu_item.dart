import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.leadingIcon});
  final String title;
  final String leadingIcon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        color: ColorManager.primary,
        leadingIcon,
        width: 24.w,
        height: 24.h,
      ),
      title: Text(title, style: AppTextStyles.font14W800White()),
      onTap: () {
        onTap();
      },
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: ColorManager.primary,
      ),
    );
  }
}

class MenuItemsList extends StatelessWidget {
  const MenuItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          title: StringsManager.editProfile,
          leadingIcon: SVGAssets.profilemenu,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.editProfileScreen);
          },
        ),
        ProfileMenuItem(
          title: StringsManager.changePassword,
          leadingIcon: SVGAssets.change,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
          },
        ),
        ProfileMenuItem(
            title: StringsManager.slectLanguage,
            leadingIcon: SVGAssets.language,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('English'),
                        onTap: () {
                          context.setLocale(const Locale('en'));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text('العربية'),
                        onTap: () {
                          context.setLocale(const Locale('ar'));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
        // ProfileMenuItem(
        //   title: StringsManager.security,
        //   leadingIcon: SVGAssets.lockSetting,
        //   routeName: AppRoutes.helpScreen,
        // ),
        // ProfileMenuItem(
        //   title: StringsManager.privacyPolicy,
        //   leadingIcon: SVGAssets.securityWarning,
        //   routeName: AppRoutes.forgetPasswordScreen,
        // ),
        ProfileMenuItem(
          title: StringsManager.help,
          leadingIcon: SVGAssets.help,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.helpScreen);
          },
        ),
        ProfileMenuItem(
          title: StringsManager.logout,
          leadingIcon: SVGAssets.logout,
          onTap: () {
            // Handle logout logic here
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreen, (route) => false);
          },
        )
      ],
    );
  }
}
