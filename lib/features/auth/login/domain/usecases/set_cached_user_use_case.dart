import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/domain/repository/login_repository.dart';

@injectable
class SetCachedUserUseCase {
  final LoginRepository _loginRepository;
  SetCachedUserUseCase(this._loginRepository);

  Future<Result<bool?>> setUser(User user, String token) async {
    return await _loginRepository.setCachedUser(user, token);
  }
}
