import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/entities/user_entity.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';

class GetUser {
  final AuthRepository _repository;

  GetUser(this._repository);

  ResultFuture<UserEntity> call(String email) async {
    return await _repository.getUserByEmail(email);
  }
}
