import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  ResultFuture<UserEntity> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String password,
    required String name,
  });

  ResultFuture<void> signOut();

  ResultFuture<UserEntity> getUserByEmail(String email);

  ResultFuture<void> saveCredentials({
    required String email,
    required String password,
  });

  ResultFuture<Map<String, String>> getSavedCredentials();

  ResultFuture<void> clearCredentials();

  ResultFuture<bool> getRememberMe();

  ResultFuture<void> setRememberMe(bool value);
}
