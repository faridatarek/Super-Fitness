import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/domain/repository/login_repository.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:super_fitness/core/common/result.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<User?> _loadUserData() async {
    User? user = UserProvider().user;
    String? token = UserProvider().token;

    if (user == null) {
      final loginRepo = getIt<LoginRepository>();
      final cachedUserResult = await loginRepo.getCachedUser();
      final cachedTokenResult = await loginRepo.checkCachedUser();

      if (cachedUserResult is Success<User> &&
          cachedTokenResult is Success<String?>) {
        user = cachedUserResult.data;
        token = cachedTokenResult.data;
        if (user != null && token != null) {
          UserProvider().setUser(user);
          UserProvider().login(token);
        }
      }
    }
    return user;
  }

  Future<void> _logout(BuildContext context) async {
    UserProvider().logout();
    await HiveManager().clearUser();
    Navigator.of(context).pushReplacementNamed(AppRoutes.splashScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: CustomAppBar(title: "Home"),
      body: FutureBuilder<User?>(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome ${user?.firstName ?? 'User'}!",
                  style: AppTextStyles.font20W800White(),
                  textAlign: TextAlign.center,
                ),
                if (user?.goal != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    "Your goal: ${user?.goal}",
                    style: AppTextStyles.font18W400White(),
                  ),
                ],
                SizedBox(height: 30.h),
                CustomButton(
                  text: "LOG OUT",
                  onPressed: () => _logout(context),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: "Go to Edit Profile",
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.editProfileScreen);
                  },
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: "Go to Chat Bot",
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.ChatScreen);
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
