class EditProfileRequest {
  String? lastName;
  String? firstName;
  String? email;
  String? activityLevel;
  String? goal;
  int? weight;

  EditProfileRequest({
    this.lastName,
    this.firstName,
    this.email,
    this.activityLevel,
    this.goal,
    this.weight,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return EditProfileRequest(
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      activityLevel: json['activityLevel'] as String?,
      goal: json['goal'] as String?,
      weight: json['weight'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'firstName': firstName,
        'email': email,
        'activityLevel': activityLevel,
        'goal': goal,
        'weight': weight,
      };
}
