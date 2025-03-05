// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/network/api_constants.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/otp_verify_reset_code_request.dart';
import 'package:super_fitness/features/forget_password/data/models/responses/Otp_verfication_response.dart';

import '../../features/forget_password/data/models/requests/create_newpass_request.dart';
import '../../features/forget_password/data/models/requests/forgot_password_request.dart';
import '../../features/forget_password/data/models/responses/Create_new_pass_respones.dart';
import '../../features/forget_password/data/models/responses/forgot_password_response.dart';
import 'api_constants.dart';

part 'api_manager.g.dart';

@singleton
@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiManager {
  @factoryMethod
  factory ApiManager(Dio dio, UserProvider provider) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = provider.token;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return _ApiManager(dio);
  }

  @POST(ApiConstants.loginPath)
  Future<LoginResponse> login(@Body() LoginRequest request);


  @POST(ApiConstants.forgetPassword)
  Future<ForgotPasswordResponse> forgotPassword(
      @Body() ForgotPasswordRequest request);

  @POST(ApiConstants.restCode)
  Future<OtpVerifyResetCodeResponse> resetCode(
      @Body() OtpVerifyResetCodeRequest request);

  @PUT(ApiConstants.createNewPassword)
  Future<CreateNewPassResponse> createNewPassword(
      @Body() CreateNewPassWordRequest request);
}

