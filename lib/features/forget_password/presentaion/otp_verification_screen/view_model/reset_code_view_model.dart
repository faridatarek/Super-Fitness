import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/otp_verify_reset_code_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Otp_verfication_response.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/forgot_password_response.dart';
import 'package:super_fitness/features/forget_password/domain/usecases/reset_code_use_case.dart';
import 'package:super_fitness/features/forget_password/presentaion/otp_verification_screen/view_model/states.dart';

import '../../../../../core/common/result.dart';
import '../../../../../utils/strings_manager.dart';
import '../../../../base/base_states.dart';
import '../../../domain/usecases/forget_password_usecase.dart';
@injectable
class OtpVerifyViewModel extends BaseCubit {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetCodeUseCase _resetCodeUseCase;

  static OtpVerifyViewModel get(BuildContext context) => BlocProvider.of<OtpVerifyViewModel>(context);

  OtpVerifyViewModel(this._forgetPasswordUseCase, this._resetCodeUseCase);
final TextEditingController otpController = TextEditingController();

  Future<void> forgetPassword(ForgotPasswordRequest request) async {
    final result = await _forgetPasswordUseCase.forgotPassword(request);
    if (result is Success<ForgotPasswordResponse?>) {
      emit(SuccessState('${result.data?.message??' '}\n${StringsManager.otpResentSuccess}'));
    } else if (result is Fail<ForgotPasswordResponse?>) {
      emit(ErrorState(result.data?.error??''));
    }
  }

  Future<void> resetCode() async {
    final result = await _resetCodeUseCase.resetCode(
      OtpVerifyResetCodeRequest(resetCode: otpController.text),
    );

    if (result is Success<OtpVerifyResetCodeResponse?>) {
      emit(CorrectOtpState());
      emit(SuccessState('${result.data?.error??' '}\n${StringsManager.otpVerifiedSuccess}'));
    } else if (result is Fail<OtpVerifyResetCodeResponse?>) {
      emit(ErrorState(result.data?.error??''));
    }
  }


  @override
  void start() {
  }
  void clearOtp() {
    otpController.clear();
  }


}

