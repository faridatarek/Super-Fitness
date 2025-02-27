import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     String? data ="";
    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: CustomAppBar(title: "Home"),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Center(child: Text("Hello $data",style: AppTextStyles.font20W800White(),)),
          SizedBox(height: 30.h,),
          Center(
            child: CustomButton(text: "LOG OuT", onPressed:() async {
              final userData = await  UserProvider().user?.goal;
              final toto = await  UserProvider().token;
              data=userData;
            //  final cleared = await HiveManager().clearUser();
              debugPrint("loggedddOutt: $userData");

             // Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);



            }),
          )
        ],),
      )
      ,);
  }
}

