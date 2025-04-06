class CreateNewPassWordRequest {
  final String email;
  final String newPassword;

  CreateNewPassWordRequest( {required this.email,required this.newPassword,});

  Map<String, dynamic> toJson() {
    return {"email": email, "newPassword": newPassword};
  }
}
