class UserModel {
  final String userId;
  final String username;
  final String email;
  final bool isAdmin;
  final String? userType;
  final String? canteenId;
  final bool isActive;

  UserModel({required this.userId, required this.username, required this.email, required this.isAdmin, required this.userType, required this.canteenId, required this.isActive});

  factory UserModel.fromDocumentSnapshot(dynamic doc) {
    return UserModel(
      userId: doc.data()['id'],
      username: doc.data()['username'],
      email: doc.data()['email'],
      isAdmin: doc.data()['is_admin'],
      userType: doc.data()['user_type'] != null ? doc.data()['user_type'] : null,
      canteenId: doc.data()['canteen_id'] != null ? doc.data()['canteen_id'] : null,
      isActive: doc.data()['is_active'],
    );
  }
}
