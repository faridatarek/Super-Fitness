
import '../../../../core/common/result.dart';
import '../../data/models/requests/forgot_password_request.dart';
import '../../data/models/responses/forgot_password_response.dart';

abstract class ForgetPasswordRepository {

  Future<Result<ForgotPasswordResponse?>> forgotPassword(ForgotPasswordRequest request);

}
