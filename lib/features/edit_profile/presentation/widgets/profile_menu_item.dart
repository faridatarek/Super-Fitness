import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.35.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileMenuItem(
              title: StringsManager.editProfile.tr(),
              leadingIcon: SVGAssets.profilemenu,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.editProfileScreen);
              },
            ),
            ProfileMenuItem(
              title: StringsManager.changePassword.tr(),
              leadingIcon: SVGAssets.change,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
              },
            ),
            ProfileMenuItem(
                title: StringsManager.slectLanguage.tr(),
                leadingIcon: SVGAssets.language,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: ColorManager.black,
                      title: Text('Select Language',
                          style: AppTextStyles.font20W800White().copyWith(
                            color: ColorManager.primary,
                          )),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              'English',
                              style: AppTextStyles.font16W500White().copyWith(
                                color: ColorManager.primary,
                              ),
                            ),
                            onTap: () {
                              context.setLocale(const Locale('en'));
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('العربية',
                                style: AppTextStyles.font16W500White().copyWith(
                                  color: ColorManager.primary,
                                )),
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
            ProfileMenuItem(
              title: StringsManager.help.tr(),
              leadingIcon: SVGAssets.help,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.helpScreen);
              },
            ),
            ProfileMenuItem(
              title: StringsManager.logout.tr(),
              leadingIcon: SVGAssets.logout,
              onTap: () {
                _logout(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.loginScreen, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    UserProvider().logout();
    await HiveManager().clearUser();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(AppRoutes.splashScreen);
  }
}
