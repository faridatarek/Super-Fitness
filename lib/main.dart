import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/common/bloc_observer.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/auth/login/data/dataSource/offline_dataSource/cache_user_model.dart';
import 'package:super_fitness/features/auth/login/data/dtos/hive_user_dto.dart';
import 'package:super_fitness/utils/theme_manger.dart';
import 'core/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CacheUserModelAdapter());

  configureDependencies();

  Bloc.observer = SimpleBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final userProvider = getIt<UserProvider>();
  String initialRoute;

  try {
    final token = await HiveManager().getToken();
    if (token != null) {
      final userModel = await HiveManager().getUser();
      final user = HiveUserDto.toEntity(userModel);
      userProvider.login(token);
      userProvider.setUser(user);
      initialRoute = AppRoutes.mainLayout;
        } else {
      initialRoute = AppRoutes.splashScreen;
    }
  } catch (e) {
    initialRoute = AppRoutes.loginScreen;
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ChangeNotifierProvider(
        create: (_) => userProvider,
        child: MyApp(initialRoute: initialRoute),
      ),
    ),
  );
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 890),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Super Fitness app',
        theme: ThemeManger.themeManger,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        onGenerateRoute: manageRoutes,
        initialRoute: initialRoute,
      ),
    );
  }
}
