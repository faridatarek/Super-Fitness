import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => isLoading = true);

    // First try to get from UserProvider
    user = UserProvider().user;
    token = UserProvider().token;

    // If not available, try to load from cache
    if (user == null) {
      final loginRepo = getIt<LoginRepository>();
      final cachedUserResult = await loginRepo.getCachedUser();
      final cachedTokenResult = await loginRepo.checkCachedUser();

      if (cachedUserResult is Success<User> &&
          cachedTokenResult is Success<String?>) {
        user = cachedUserResult.data;
        token = cachedTokenResult.data;
        if (user != null && token != null) {
          UserProvider().setUser(user!);
          UserProvider().login(token!);
        }
      }
    }

    setState(() => isLoading = false);
  }

  Future<void> _logout() async {
    setState(() => isLoading = true);
    UserProvider().logout();
    await HiveManager().clearUser();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
    }
  }

  void _printUserData() {
    debugPrint("User Data: ${user?.toJson()}");
    debugPrint("User Goal: ${user?.goal}");
    debugPrint("User Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: CustomAppBar(title: "Home"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    onPressed: _logout,
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
                  CustomButton(
                    text: "Print User Data",
                    onPressed: _printUserData,
                  ),
                ],
              ),
            ),
    );
  }
}
