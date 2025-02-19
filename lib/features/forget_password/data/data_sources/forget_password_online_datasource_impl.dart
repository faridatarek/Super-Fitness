import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/create_newpass_request.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/otp_verify_reset_code_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Create_new_pass_respones.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Otp_verfication_response.dart';

import '../../../../core/common/result.dart';
import '../../../../core/network/api_execution.dart';
import '../../../../core/network/api_manager.dart';
import '../contracts/forget_password_online_datasource.dart';
import '../models/requests/forgot_password_request.dart';
import '../models/responses/forgot_password_response.dart';

@Injectable(as: ForgetPasswordOnlineDatasource)
class ForgetPasswordOnlineDatasourceImpl implements ForgetPasswordOnlineDatasource {
  final ApiManager apiManager;
  ForgetPasswordOnlineDatasourceImpl(this.apiManager);

  @override
  Future<Result<ForgotPasswordResponse?>> forgotPassword(ForgotPasswordRequest request) async {
    try {
      final result = await apiManager.forgotPassword(request);
      return Success(result);
    } catch (e) {
      if (e is DioException) {
        String errorMessage = _handleDioError(e);
        return Fail(Exception(errorMessage), data: ForgotPasswordResponse(error: errorMessage));
      }
      return Fail(Exception("Unexpected error: ${e.toString()}"));
    }
  }




  @override
  Future<Result<OtpVerifyResetCodeResponse?>> resetPassword(OtpVerifyResetCodeRequest request)async {
    try {
      final result = await apiManager.resetCode(request);
      return Success(result);
    } catch (e) {
      if (e is DioException) {
        String errorMessage = _handleDioError(e);
        return Fail(Exception(errorMessage), data: OtpVerifyResetCodeResponse(error: errorMessage));
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
      if (response.data is Map<String, dynamic> && response.data.containsKey("error")) {
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

  @override
  Future<Result<CreateNewPassResponse ?>> createNewPass(CreateNewPassWordRequest request) async{
    try {
      final result = await apiManager.createNewPassword(request);
      return Success(result);
    } catch (e) {
      if (e is DioException) {
        String errorMessage = _handleDioError(e);
        return Fail(Exception(errorMessage), data: CreateNewPassResponse(error: errorMessage));
      }
      return Fail(Exception("Unexpected error: ${e.toString()}"));
    }
  }
}
