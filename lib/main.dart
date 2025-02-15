import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/common/bloc_observer.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';

import 'core/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = SimpleBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ChangeNotifierProvider(
          create: (BuildContext context) {
            return UserProvider();
          },
          child: const MyApp())));
}
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffFF4100),
              primary: const Color(0xffFF4100),
              onError: Colors.red,
              secondary: const Color(0xffA6A6A6)),
          useMaterial3: true,
        ),

        onGenerateRoute: manageRoutes,
        initialRoute: AppRoutes.homeScreen,
      ),
    );
  }
}
