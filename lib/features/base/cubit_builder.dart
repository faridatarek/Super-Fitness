import 'package:flutter/material.dart';
import '../../../../utils/assets_manager.dart';
import '../../../../utils/color_manager.dart';
import 'base_states.dart';
import 'base_widgets.dart';

Widget baseBuilder(BuildContext context, BaseState state, Widget child) {
  if (state is LoadingState) {
    return BaseWidgets.buildItemsColumn([
      BaseWidgets.buildAnimatedImage(LottieAssets.loading),

    ]);
  } else if (state is SuccessState) {
    return BaseWidgets.buildItemsColumn([
      BaseWidgets.buildAnimatedImage(LottieAssets.success, false),
      BaseWidgets.buildMessage(
        context,
        state.message ,
        ColorManager.black,
      ),

    ]);
  } else if (state is EmptyState) {
    return BaseWidgets.buildItemsColumn([
      BaseWidgets.buildAnimatedImage(LottieAssets.error, false),
      BaseWidgets.buildMessage(
        context,
        state.message ?? 'No Content Found',
        ColorManager.black,
      ),
      BaseWidgets.buildButton(
        displayType: state.displayType,
        context: context,
        onTap: state.retry,
        title: 'Try again',
      ),
    ]);
  } else if (state is ErrorState) {
    return BaseWidgets.buildItemsColumn([
      BaseWidgets.buildAnimatedImage(LottieAssets.error, false),
      BaseWidgets.buildMessage(
        context,
        state.errorMessage ,
        ColorManager.black,
      ),
    ]);
  }

  return child;
}
