import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/values_manager.dart';

import 'base_states.dart';

class BaseWidgets {
  BaseWidgets._();

  // Generic image widget
  static Widget buildImage(String imgPath) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Image.asset(imgPath),
    );
  }

  // Lottie animation widget
  static Widget buildAnimatedImage(String lottiePath, [bool repeat = true]) {
    return Center(
      child: SizedBox(
        height: AppSize.s200,
        width: AppSize.s200,
        child: Lottie.asset(lottiePath, repeat: repeat),
      ),
    );
  }

  static Widget buildItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  static Widget buildMessage(BuildContext context, String message,
      [Color? textColor, double? fontSize]) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: fontSize ?? 16.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void showPopUpDialog(BuildContext context, List<Widget> children,
      {List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: actions,
        backgroundColor: Colors.black.withOpacity(0.7),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildButton({
    required DisplayType displayType,
    required BuildContext context,
    required String title,
    void Function()? onTap,
    ButtonStyle? buttonStyle,
    double? width,
    double? height,
  }) {
    if (onTap == null) return const SizedBox();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: buttonStyle ??
                ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppPadding.p8),
                ),
            onPressed: () {
              if (displayType == DisplayType.popUpDialog) {
                Navigator.of(context).pop();
              }
              onTap();
            },
            child: Text(
              title,
              style: const TextStyle(color: Colors.deepOrange),
            ),
          ),
        ),
      ),
    );
  }
}
