import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/forget_password/domain/data_intent/data_intent.dart';

@injectable
class CreateNewPassWordViewModel extends BaseCubit  {

  final TextEditingController passWordController = TextEditingController();
  final TextEditingController emailController =
  TextEditingController(text: DataIntent.getUserMail() ?? '');
  static CreateNewPassWordViewModel get(BuildContext context) => BlocProvider.of<CreateNewPassWordViewModel>(context);

  CreateNewPassWordViewModel();


  // Future<void> forgetPassWord(ForgotPasswordRequest request) async {
  //   emit(LoadingState());
  //
  //   final result = await _forgetPasswordUseCase.forgotPassword(request);
  //
  //   if (result is Success<ForgotPasswordResponse?>) {
  //     emit(SuccessState('${result.data?.error??' '}\n${StringsManager.otpResentSuccess}'));
  //     DataIntent.setUserMail(request.email);
  //   } else if (result is Fail<ForgotPasswordResponse?>) {
  //     emit(ErrorState(result.data?.error ?? ''));
  //   }
  // }

  @override
  void start() {
  }



}
