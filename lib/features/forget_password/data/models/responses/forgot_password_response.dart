class ForgotPasswordResponse {
  final String? message;
  final String? error;
  final String? info;

  ForgotPasswordResponse({this.message, this.info,this.error});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      message: json['message'],
      error: json['error'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "error": error,
      "info": info,
    };
  }
}
