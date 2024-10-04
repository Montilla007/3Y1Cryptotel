class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? token;
  bool? hasCompletedOnboarding;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.token,
      this.hasCompletedOnboarding});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        token: json['token'],
        hasCompletedOnboarding: json['hasCompletedOnboarding']);
  }
}
