import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/common/bloc_observer.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/data/dataSource/offline_dataSource/cache_user_model.dart';

import 'core/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CacheUserModelAdapter());
  configureDependencies();
  Bloc.observer = SimpleBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  String initialRoute;
  try {
    final token = await HiveManager().getToken();
    debugPrint("tokeeeennnn: $token");
    if (token != null) {
      final userModel = await HiveManager().getUser();
      debugPrint("userModel: ${userModel.firstName}, ${userModel.email}");
      if (userModel != null) {
        UserProvider().login(token);
        UserProvider().setUser(userModel as User);
        initialRoute = AppRoutes.homeScreen;
      } else {
        initialRoute = AppRoutes.loginScreen;
      }
    } else {
      initialRoute = AppRoutes.loginScreen;
    }
  } catch (e, stack) {
    initialRoute = AppRoutes.homeScreen;
  }
  runApp(
      ChangeNotifierProvider(
          create: (BuildContext context) {
            return UserProvider();
          },
          child:  MyApp(initialRoute: initialRoute)));
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffFF4100),
              primary: const Color(0xffFF4100),
              onError: Colors.red,
              secondary: const Color(0xffA6A6A6)),
          useMaterial3: true,
        ),

        onGenerateRoute: manageRoutes,
        initialRoute: initialRoute,
      ),
    );
  }
}
