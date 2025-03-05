import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class Message extends StatelessWidget {
  final userProvider = getIt<UserProvider>();
  final String text;
  final bool sender;
  final bool hasImage;
  final dynamic file;

  Message({required this.text, required this.sender, required this.hasImage, this.file});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (file != null)
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                image: file != null ? DecorationImage(image: FileImage(file), fit: BoxFit.contain) : null,
                color: ColorManager.chatColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: sender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!sender)
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0.w,right: 3.w),
                    child: CircleAvatar(
                      radius: 23.r,
                      backgroundColor: ColorManager.primary,
                      backgroundImage: AssetImage(PNGAssets.chatBotImg),
                    ),
                  ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: sender ? ColorManager.chatColor.withOpacity(0.7) : ColorManager.chatBotmessage.withOpacity(0.8),
                      borderRadius: sender
                          ? BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          : BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),
                    child: Text(
                      text,
                      style: AppTextStyles.font18W400White(fontWeight: FontWeight.w500),
                      softWrap: true,
                    ),
                  ),
                ),
                if (sender)
                  Padding(
                    padding:EdgeInsets.only(right: 8.0.w,left: 3.w),
                    child: CircleAvatar(
                      radius: 23.r,
                      backgroundColor: ColorManager.primary,
                      backgroundImage: NetworkImage(userProvider.user?.photo?? "https://thumbs.dreamstime.com/b/strong-muscle-illustration-60892521.jpg"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}