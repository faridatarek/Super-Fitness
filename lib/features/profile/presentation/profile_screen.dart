import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/features/profile/presentation/widgets/options_container.dart';
import 'package:super_fitness/utils/assets_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Profile",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.profileBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 130.0.h),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://s3-alpha-sig.figma.com/img/c242/cbe4/af018c2a47078910206d0f21a200a029?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Mmo4KJAJmpf4ZAT5l0N91jieD57Ugr17qqKDqSxLLxksQaJmENANgjMqxhKSVF76UwUyq9GqVGgCwxeIzquzLEaAdzIsJac4NAdlSYuo8SY-X3~nLLGI9caNczQKIuS9OZGtxWcj0B9f~xVnxYUGTPjC~DgRpA6gDIzmqC9Fcqyj9gtUkp1vv~G3tiT05bei6jOBOMgoFvXK4Ruo2dWcVYTj9rFitK4RSp0xjFH5wrzPRIP7g3NMqn6wi729BoC1gcOs8MzsRbAEuj4f3cDHLilARvc~NGXS6G6ek2LEzjjCoTwWot3Ytw-xoFlgOjRXzo7nAMXBoEc5jpHRRkcFOw__",
                  ),
                  radius: 60.sp,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ahmed Mohamed",
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                OptionsContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
