import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/result.dart';
import '../../../../core/network/api_execution.dart';
import '../../../../core/network/api_manager.dart';
import '../contracts/forget_password_online_datasource.dart';
import '../models/requests/forgot_password_request.dart';
import '../models/responses/forgot_password_response.dart';


@Injectable(as: ForgetPasswordOnlineDatasource)
class ForgetPasswordOnlineDatasourceImpl
    implements ForgetPasswordOnlineDatasource {
  final ApiManager apiManager;
  ForgetPasswordOnlineDatasourceImpl(this.apiManager);



  @override
  Future<Result<ForgotPasswordResponse?>> forgotPassword( ForgotPasswordRequest request) async {
    try {
      final result = await apiManager.forgotPassword(request);
      return Success(result);
    } catch (e) {
      if (e is DioException) {
        String errorMessage = _handleDioError(e);
        return Fail(Exception(errorMessage), data: ForgotPasswordResponse(error: errorMessage));
      }
      return Fail(Exception(e.toString()));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> && errorData.containsKey("error")) {
          return errorData["error"];
        }
      } catch (error) {
        return "Error processing response.";
      }
    }
    return e.message ?? "An unknown error occurred.";
  }
}
