import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/forgot_password_response.dart';
import 'package:super_fitness/features/forget_password/domain/data_intent/data_intent.dart';

import '../../../../../core/common/result.dart';
import '../../../../../utils/strings_manager.dart';
import '../../../../base/base_states.dart';
import '../../../domain/usecases/forget_password_usecase.dart';
@injectable
class ForgetPassWordViewModel extends BaseCubit {
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  final TextEditingController forgetPassWordTextField = TextEditingController();
  static ForgetPassWordViewModel get(BuildContext context) => BlocProvider.of<ForgetPassWordViewModel>(context);

  ForgetPassWordViewModel(this._forgetPasswordUseCase);


  Future<void> forgetPassWord(ForgotPasswordRequest request) async {
    emit(LoadingState());

    final result = await _forgetPasswordUseCase.forgotPassword(request);

    if (result is Success<ForgotPasswordResponse?>) {
      emit(SuccessState('${result.data?.error??' '}\n${StringsManager.otpResentSuccess}'));
      DataIntent.setUserMail(request.email);
    } else if (result is Fail<ForgotPasswordResponse?>) {
      emit(ErrorState(result.data?.error ?? ''));
    }
  }

  @override
  void start() {

  }


}
