
import '../../../../core/common/result.dart';
import '../models/requests/forgot_password_request.dart';
import '../models/responses/forgot_password_response.dart';

abstract class ForgetPasswordOnlineDatasource {

  Future<Result<ForgotPasswordResponse?>> forgotPassword(ForgotPasswordRequest request);

}
