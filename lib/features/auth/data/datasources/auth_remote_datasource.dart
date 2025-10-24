import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_order/core/constants/app_constants.dart';
import 'package:purchase_order/core/error/exceptions.dart';
import 'package:purchase_order/core/network/firebase_service.dart';
import 'package:purchase_order/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();

  Future<UserModel> getUserByEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseService _firebaseService;

  AuthRemoteDataSourceImpl(this._firebaseService);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseService.auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return await getUserByEmail(email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? AppConstants.unknownError);
    } catch (e) {
      if (e.toString().startsWith(
          'ClientException with SocketException: Failed host lookup:')) {
        throw NetworkException(AppConstants.noInternetError);
      }
      throw AuthException(AppConstants.unknownError);
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseService.auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = UserModel(
        email: email,
        name: name,
        userId: credential.user!.uid,
        dateCreated: DateTime.now(),
      );

      await _firebaseService.firestore
          .collection(AppConstants.usersCollection)
          .doc(credential.user!.uid)
          .set(user.toMap());
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? AppConstants.unknownError);
    } catch (e) {
      throw AuthException(AppConstants.unknownError);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseService.auth.signOut();
    } catch (e) {
      throw AuthException('Failed to sign out');
    }
  }

  @override
  Future<UserModel> getUserByEmail(String email) async {
    try {
      final snapshot = await _firebaseService.firestore
          .collection(AppConstants.usersCollection)
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        throw AuthException('User not found');
      }

      return UserModel.fromMap(snapshot.docs.first.data());
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException('Failed to fetch user data');
    }
  }
}
