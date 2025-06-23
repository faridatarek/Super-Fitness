import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/local/hive/hive_execution.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/data/contracts/offline_dataSource.dart';
import 'package:super_fitness/features/auth/login/data/dtos/hive_user_dto.dart';

@Injectable(as: OfflineDataSource)
class OfflineDataSourceImpl implements OfflineDataSource {
  final HiveManager _hiveManager;
  OfflineDataSourceImpl(this._hiveManager);
  @override
  Future<Result<String?>> checkUser() {
    return executeHive(() async {
      return await _hiveManager.getToken();
    });
  }

  @override
  Future<Result<User>> getUser() {
    return executeHive(() async {
      final result = await _hiveManager.getUser();
      return HiveUserDto.toEntity(result);
    });
  }

  @override
  Future<Result<bool>> setUser(User user, String token) {
    return executeHive(() async {
      final result =
      await _hiveManager.setUser(HiveUserDto.toHiveModel(user), token);
      return result;
    });


  }

  @override
  Future<Result<bool>> clearUserData() {
    return executeHive(() async {
      final success = await _hiveManager.clearUser();
      if (success) {
        return true;
      } else {
        throw Exception('Failed to clear user data');
      }
    });
  }}