import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository _repository;

  SignUp(this._repository);

  ResultFuture<void> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return await _repository.signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}
