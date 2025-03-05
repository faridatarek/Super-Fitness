class CreateNewPassResponse {
  CreateNewPassResponse({
    this.message,
    this.error,
    this.token,
  });

  CreateNewPassResponse.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    token = json['token'];
  }

  String? message;
  String? error;
  String? token;

  CreateNewPassResponse copyWith({
    String? message,
    String? error,
    String? token,
  }) => CreateNewPassResponse(
    message: message ?? this.message,
    error: error ?? this.error,
    token: token ?? this.token,
  );

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "message": message,
      "token": token,
    };
  }
}
