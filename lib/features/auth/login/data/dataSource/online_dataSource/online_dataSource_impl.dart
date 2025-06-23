
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/network/api_execution.dart';
import 'package:super_fitness/core/network/api_manager.dart';
import 'package:super_fitness/features/auth/login/data/contracts/online_dataSource.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl implements OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);
  @override
  Future<Result<LoginResponse?>> login(LoginRequest request) {
    return executeApi(() async {
      final result = await _apiManager.login(request);
      return result;
    });
  }

}
