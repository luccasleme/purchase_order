import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.name,
    required super.userId,
    super.dateCreated,
  });

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      dateCreated: map['dateCreated'] != null
          ? (map['dateCreated'] as dynamic).toDate()
          : null,
    );
  }

  DataMap toMap() {
    return {
      'email': email,
      'name': name,
      'userId': userId,
      'dateCreated': dateCreated,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      email: entity.email,
      name: entity.name,
      userId: entity.userId,
      dateCreated: entity.dateCreated,
    );
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? userId,
    DateTime? dateCreated,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}
