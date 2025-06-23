import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/network/api_execution.dart';
import 'package:super_fitness/core/network/api_manager.dart';
import 'package:super_fitness/features/auth/register/data/contracts/register_online_datasource.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/data/models/response/register_response/register_response.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';

@Injectable(as: RegisterOnlineDataSource)
class RegisterOnlineDatasourceImpl implements RegisterOnlineDataSource {
  final ApiManager _apiManager;

  RegisterOnlineDatasourceImpl(this._apiManager);
  @override
  Future<Result<RegisterResponseEntity?>> register(RegisterRequest request) {
    return executeApi(() async {
      final response = await _apiManager.register(request);
      return RegisterResponse(
        message: response?.message,
        user: response?.user,
        token: response?.token,
      ).toEntity();
    });
  }
}
