import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/data/contracts/offline_dataSource.dart';
import 'package:super_fitness/features/auth/login/data/contracts/online_dataSource.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';
import 'package:super_fitness/features/auth/login/domain/repository/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepoImpl implements LoginRepository {
  final OnlineDataSource _onlineDataSource;
  final OfflineDataSource _offlineDataSource;
  LoginRepoImpl(this._onlineDataSource, this._offlineDataSource);
  @override
  Future<Result<LoginResponse?>> login(LoginRequest request) async {
    final result = await _onlineDataSource.login(request);
    switch (result) {
      case Success<LoginResponse?>():
        UserProvider().login(result.data!.token!);
        return result;
      case Fail<LoginResponse?>():
        return result;
    }
  }

  @override
  Future<Result<String?>> checkCachedUser() async {
    final result = await _offlineDataSource.checkUser();
    switch (result) {
      case Success<String?>():
        if (result.data != null) {
          getIt<UserProvider>().login(result.data!);
        }
        return result;
      case Fail<String?>():
        return result;
    }
  }

  @override
  Future<Result<User>> getCachedUser() async {
    final result = await _offlineDataSource.getUser();
    switch (result) {
      case Success<User>():
        getIt<UserProvider>().setUser(result.data!);
        return result;
      case Fail<User>():
        return result;
    }
  }

  @override
  Future<Result<bool>> setCachedUser(User user, String token) async {
    final result = await _offlineDataSource.setUser(user, token);
    return result;
  }
}
