import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/strings_manager.dart';

import 'base_states.dart';
import 'base_widgets.dart';

void baseListener(BuildContext context, BaseState state) {
  if (state.displayType == DisplayType.fullScreen) return;
  if (state is InitialState) {
    //do nothing
  } else if (state is SuccessState) {
    BaseWidgets.showPopUpDialog(context, [
      BaseWidgets.buildAnimatedImage(LottieAssets.success, false),
      BaseWidgets.buildMessage(context, state.message),
    ]);
  } else if (state is LoadingState) {
    BaseWidgets.showPopUpDialog(context, [
      BaseWidgets.buildAnimatedImage(LottieAssets.loading),
    ]);
  } else if (state is ErrorState) {
    BaseWidgets.showPopUpDialog(
      context,
      [
        BaseWidgets.buildAnimatedImage(LottieAssets.error, false),
        BaseWidgets.buildMessage(context, state.errorMessage),
        BaseWidgets.buildButton(
          displayType: state.displayType,
          context: context,
          // onTap: state.retry,
          title: StringsManager.retryAgain.tr(),
        ),
      ],
    );
  }
}