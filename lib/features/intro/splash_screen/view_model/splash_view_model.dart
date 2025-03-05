import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/intro/splash_screen/view_model/splash_state.dart';


class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startTimer() {
    Future.delayed(const Duration(seconds: 2), () {
      emit(SplashFinished());
    });
  }
}
