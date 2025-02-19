
import 'package:super_fitness/features/forget_password/data/models/requests/create_newpass_request.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/otp_verify_reset_code_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Otp_verfication_response.dart';

import '../../../../core/common/result.dart';
import '../models/requests/forgot_password_request.dart';
import '../models/responses/Create_new_pass_respones.dart';
import '../models/responses/forgot_password_response.dart';

abstract class ForgetPasswordOnlineDatasource {

  Future<Result<ForgotPasswordResponse?>> forgotPassword(ForgotPasswordRequest request);
  Future<Result<OtpVerifyResetCodeResponse?>> resetPassword(OtpVerifyResetCodeRequest request);
  Future<Result< CreateNewPassResponse ?>> createNewPass(CreateNewPassWordRequest request);

}
