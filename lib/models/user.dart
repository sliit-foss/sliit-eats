class UserModel {
  final String userId;
  final String username;
  final String email;
  final String userRole;
  final String userType;

  UserModel({required this.userId, required this.username, required this.email, required this.userRole, required this.userType});

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      userRole: json['user_role'],
      userType: json['user_type'] != null ? json['user_type'] : '',
    );
  }
}
