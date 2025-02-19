import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/otp_verify_reset_code_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Otp_verfication_response.dart';
import '../../../../core/common/result.dart';
import '../repositories/forget_password_repository.dart';

@injectable
class ResetCodeUseCase {
  final ForgetPasswordRepository _forgetPasswordRepository;

  ResetCodeUseCase(this._forgetPasswordRepository);

  Future<Result<OtpVerifyResetCodeResponse?>> resetCode(
      OtpVerifyResetCodeRequest request) async {
    return await _forgetPasswordRepository.resetCode(request);
  }



}
