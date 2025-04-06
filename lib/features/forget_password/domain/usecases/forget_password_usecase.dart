import 'package:injectable/injectable.dart';

import '../../../../core/common/result.dart';
import '../../data/models/requests/forgot_password_request.dart';
import '../../data/models/responses/forgot_password_response.dart';
import '../repositories/forget_password_repository.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepository _forgetPasswordRepository;

  ForgetPasswordUseCase(this._forgetPasswordRepository);

  Future<Result<ForgotPasswordResponse?>> forgotPassword(
      ForgotPasswordRequest request) async {
    return await _forgetPasswordRepository.forgotPassword(request);
  }



}
