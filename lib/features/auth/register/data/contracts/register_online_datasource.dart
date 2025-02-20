import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';

abstract class RegisterOnlineDataSource {
  Future<Result<RegisterResponseEntity?>> register(RegisterRequest request);
}
