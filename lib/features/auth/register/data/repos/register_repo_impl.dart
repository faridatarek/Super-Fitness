import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/register/data/contracts/register_online_datasource.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';
import 'package:super_fitness/features/auth/register/domain/repos/register_repo.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImpl implements RegisterRepo {
  final RegisterOnlineDataSource _registerOnlineDataSource;

  RegisterRepoImpl(this._registerOnlineDataSource);
  @override
  Future<Result<RegisterResponseEntity?>> register(RegisterRequest request) {
    return _registerOnlineDataSource.register(request);
  }
}
