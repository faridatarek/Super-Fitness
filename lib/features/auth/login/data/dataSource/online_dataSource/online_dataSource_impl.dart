import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/network/api_manager.dart';
import 'package:super_fitness/features/auth/login/data/contracts/online_dataSource.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl implements OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);

  @override
  Future<Result<LoginResponse?>> login(LoginRequest request) async {
    try {
      final response = await _apiManager.login(request);

      final result = LoginResponse(
        message: response?.message,
        token: response?.token,
        user: response?.user,
      );

      return Success(result);
    } catch (e) {
      if (e is DioException) {
        String errorMessage = _handleDioError(e);
        return Fail(
          Exception(errorMessage),
          data: LoginResponse(message: errorMessage),
        );
      }
      return Fail(Exception("Unexpected error: ${e.toString()}"));
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return "Connection timed out. Please try again.";

      case DioExceptionType.badResponse:
        if (e.response != null) {
          return _parseServerError(e.response!);
        }
        return "Received invalid response from server.";

      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network.";

      case DioExceptionType.cancel:
        return "Request was cancelled. Please try again.";

      case DioExceptionType.unknown:
        return "An unknown error occurred. Please try again later.";

      default:
        return e.message ?? "An unexpected error occurred.";
    }
  }

  String _parseServerError(Response response) {
    try {
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey("error")) {
        return response.data["error"];
      } else if (response.statusCode == 401) {
        return "Invalid email or password.";
      } else if (response.statusCode == 403) {
        return "Access denied. Please contact support.";
      } else if (response.statusCode == 404) {
        return "Login service not found.";
      } else if (response.statusCode == 500) {
        return "Server error. Please try again later.";
      }
    } catch (_) {}
    return "Unexpected server response.";
  }
}
