import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';
import 'package:super_fitness/features/auth/register/domain/repos/register_repo.dart';

@injectable
class RegisterUsecase {
  final RegisterRepo _registerRepo;

  RegisterUsecase(this._registerRepo);

  Future<Result<RegisterResponseEntity?>> register(RegisterRequest request) =>
      _registerRepo.register(request);
}
