import 'package:injectable/injectable.dart';

import '../../../../core/common/result.dart';
import '../../domain/repositories/forget_password_repository.dart';
import '../contracts/forget_password_online_datasource.dart';
import '../models/requests/forgot_password_request.dart';
import '../models/responses/forgot_password_response.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl extends ForgetPasswordRepository {
  final ForgetPasswordOnlineDatasource _forgetPasswordOnlineDatasource;
  ForgetPasswordRepositoryImpl(this._forgetPasswordOnlineDatasource);

  @override
  Future<Result<ForgotPasswordResponse?>> forgotPassword(
      ForgotPasswordRequest request) async {
    return await _forgetPasswordOnlineDatasource.forgotPassword(request);
  }


}
