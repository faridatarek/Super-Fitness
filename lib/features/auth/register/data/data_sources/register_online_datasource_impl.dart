import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
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
  Future<Result<RegisterResponseEntity?>> register(
      RegisterRequest request) async {
    try {
      final response = await _apiManager.register(request);

      final entity = RegisterResponse(
        message: response?.message,
        user: response?.user,
        token: response?.token,
      ).toEntity();

      return Success(entity);
    } catch (e) {
      if (e is DioException) {
        String errorMessage = _handleDioError(e);
        return Fail(
          Exception(errorMessage),
          data: RegisterResponse(message: errorMessage).toEntity(),
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
        return "Unauthorized access. Please login again.";
      } else if (response.statusCode == 403) {
        return "Access denied. You do not have permission.";
      } else if (response.statusCode == 404) {
        return "Requested resource not found.";
      } else if (response.statusCode == 500) {
        return "Server error. Please try again later.";
      }
    } catch (_) {}
    return "Unexpected server response.";
  }
}
