import 'package:super_fitness/core/network/api_error_handler.dart';

String extractErrorMessage(Exception? exception) {
  var message = "something went wrong";
  if (exception is NoInternetError) {
    message = "please check internet connection";
  } else if (exception is ServerError) {
    message = exception.serverMessage ?? "something went wrong";
  } else if (exception is DioHttpException) {
    if (exception.exception?.response?.statusCode == 409) {
      message = "user already exists";
    }
    message =
        exception.exception?.response!.data['error'] ?? "something went wrong";
  }
  return message;
}
