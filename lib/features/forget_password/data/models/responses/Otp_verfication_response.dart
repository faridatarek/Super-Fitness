class OtpVerifyResetCodeResponse {
  OtpVerifyResetCodeResponse({this.status, this.error});

  OtpVerifyResetCodeResponse.fromJson(dynamic json) {
    status = json['status'];
    error = json['error'];
  }
  String? status;
  String? error;
  OtpVerifyResetCodeResponse copyWith({
    String? status,
    String? error,
  }) =>
      OtpVerifyResetCodeResponse(
        status: status ?? this.status,
        error: error ?? this.error,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error'] = error;
    return map;
  }
}
