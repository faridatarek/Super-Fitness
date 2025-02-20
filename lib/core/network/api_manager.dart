import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/network/api_constants.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';
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
}
