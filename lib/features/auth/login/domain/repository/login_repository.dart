import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';

abstract class LoginRepository {
  Future<Result<LoginResponse?>> login(LoginRequest request);
  Future<Result<String?>> checkCachedUser();
  Future<Result<User>> getCachedUser();
  Future<Result<bool>> setCachedUser(User user, String token);
}
