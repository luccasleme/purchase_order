import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/entities/user_entity.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository _repository;

  SignIn(this._repository);

  ResultFuture<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return await _repository.signIn(email: email, password: password);
  }
}
