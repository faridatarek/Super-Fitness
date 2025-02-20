import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';

abstract class OnlineDataSource {
  Future<Result<LoginResponse?>> login(LoginRequest request);

}