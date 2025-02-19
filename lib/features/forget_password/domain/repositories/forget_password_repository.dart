
import 'package:super_fitness/features/forget_password/data/models/requests/create_newpass_request.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/otp_verify_reset_code_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Otp_verfication_response.dart';

import '../../../../core/common/result.dart';
import '../../data/models/requests/forgot_password_request.dart';
import '../../data/models/responses/Create_new_pass_respones.dart';
import '../../data/models/responses/forgot_password_response.dart';

abstract class ForgetPasswordRepository {

  Future<Result<ForgotPasswordResponse?>> forgotPassword(ForgotPasswordRequest request);
  Future<Result<OtpVerifyResetCodeResponse?>> resetCode(OtpVerifyResetCodeRequest request);
  Future<Result<CreateNewPassResponse ?>> createNewPassword(CreateNewPassWordRequest request);

}
