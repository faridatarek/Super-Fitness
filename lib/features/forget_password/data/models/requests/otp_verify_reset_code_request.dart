class OtpVerifyResetCodeRequest {
  final String resetCode;

  OtpVerifyResetCodeRequest({required this.resetCode});

  Map<String, dynamic> toJson() {
    return {"resetCode": resetCode};
  }
}
