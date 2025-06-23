
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';
import 'package:super_fitness/features/auth/login/domain/repository/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository _loginRepository;
  LoginUseCase(this._loginRepository);
  Future<Result<LoginResponse?>> login(LoginRequest request) async {
    return await _loginRepository.login(request);
  }
}
