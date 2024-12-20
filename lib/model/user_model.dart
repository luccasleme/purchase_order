class UserModel {
  String email;
  String userId;
  DateTime dateCreated = DateTime.now();

  static Map<String, dynamic> toMap(UserModel userModel) {
    final Map<String, dynamic> user = {
      'email': userModel.email,
      'userId': userModel.userId,
      'dateCreated': userModel.dateCreated,
    };
    return user;
  }

  UserModel(
      {required this.email, required this.userId});
}
