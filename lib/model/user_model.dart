import 'package:purchase_order/utils/database.dart';

class UserModel {
  String email;
  String name;
  String userId;
  DateTime dateCreated = DateTime.now();

  static Future<UserModel> userFromDB(String email) async {
    Map<String,dynamic> user;
    var snapshot = db.collection('users');
    final query = await snapshot.where('email', isEqualTo: email).get();
    user = query.docs[0].data();
    final UserModel userFromMap = UserModel(
      email: user['email'],
      userId: user['userId'],
      name: user['name'],
    );
    return userFromMap;
  }

  static Map<String, dynamic> toMap(UserModel userModel) {
    final Map<String, dynamic> user = {
      'email': userModel.email,
      'userId': userModel.userId,
      'name': userModel.name,
      'dateCreated': userModel.dateCreated,
    };
    return user;
  }

  UserModel({required this.email, required this.userId, required this.name});
}
