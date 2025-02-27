import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/create_newpass_request.dart';

import '../../../../core/common/result.dart';
import '../../data/models/responses/Create_new_pass_respones.dart';
import '../repositories/forget_password_repository.dart';

@injectable
class CreateNewPasswordUseCase {
  final ForgetPasswordRepository _forgetPasswordRepository;

  CreateNewPasswordUseCase(this._forgetPasswordRepository);

  Future<Result<CreateNewPassResponse?>> createNewPass(
      CreateNewPassWordRequest request) async {
    return await _forgetPasswordRepository.createNewPassword(request);
  }



}
