import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository _repository;

  SignOut(this._repository);

  ResultFuture<void> call() async {
    return await _repository.signOut();
  }
}
