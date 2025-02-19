// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/forget_password/data/models/requests/forgot_password_request.dart';
import '../../features/forget_password/data/models/responses/forgot_password_response.dart';
import 'api_constants.dart';

part 'api_manager.g.dart';

@singleton
@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiManager {
  @factoryMethod
  factory ApiManager(Dio dio, ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {

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


  @POST(ApiConstants.forgetPassword)
  Future<ForgotPasswordResponse> forgotPassword(
      @Body() ForgotPasswordRequest request);


}