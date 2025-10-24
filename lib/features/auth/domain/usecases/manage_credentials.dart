import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';

class SaveCredentials {
  final AuthRepository _repository;

  SaveCredentials(this._repository);

  ResultFuture<void> call({
    required String email,
    required String password,
  }) async {
    return await _repository.saveCredentials(
      email: email,
      password: password,
    );
  }
}

class GetSavedCredentials {
  final AuthRepository _repository;

  GetSavedCredentials(this._repository);

  ResultFuture<Map<String, String>> call() async {
    return await _repository.getSavedCredentials();
  }
}

class ClearCredentials {
  final AuthRepository _repository;

  ClearCredentials(this._repository);

  ResultFuture<void> call() async {
    return await _repository.clearCredentials();
  }
}
