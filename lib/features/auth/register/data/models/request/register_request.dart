class RegisterRequest {
	String? firstName;
	String? lastName;
	String? email;
	String? password;
	String? rePassword;
	String? gender;
	int? height;
	int? weight;
	int? age;
	String? goal;
	String? activityLevel;

	RegisterRequest({
		this.firstName, 
		this.lastName, 
		this.email, 
		this.password, 
		this.rePassword, 
		this.gender, 
		this.height, 
		this.weight, 
		this.age, 
		this.goal, 
		this.activityLevel, 
	});

	factory RegisterRequest.fromJson(Map<String, dynamic> json) {
		return RegisterRequest(
			firstName: json['firstName'] as String?,
			lastName: json['lastName'] as String?,
			email: json['email'] as String?,
			password: json['password'] as String?,
			rePassword: json['rePassword'] as String?,
			gender: json['gender'] as String?,
			height: json['height'] as int?,
			weight: json['weight'] as int?,
			age: json['age'] as int?,
			goal: json['goal'] as String?,
			activityLevel: json['activityLevel'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'firstName': firstName,
				'lastName': lastName,
				'email': email,
				'password': password,
				'rePassword': rePassword,
				'gender': gender,
				'height': height,
				'weight': weight,
				'age': age,
				'goal': goal,
				'activityLevel': activityLevel,
			};
}
