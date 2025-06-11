class UpdateProfileImageResponse {
  String? message;

  UpdateProfileImageResponse({this.message});

  factory UpdateProfileImageResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileImageResponse(
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
