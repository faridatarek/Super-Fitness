import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';

abstract class OfflineDataSource {
  Future<Result<String?>> checkUser();
  Future<Result<bool>> setUser(User user, String token);
  Future<Result<User>> getUser();
  Future<Result<bool>> clearUserData();
}