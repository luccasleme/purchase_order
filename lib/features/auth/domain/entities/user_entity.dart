import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String name;
  final String userId;
  final DateTime? dateCreated;

  const UserEntity({
    required this.email,
    required this.name,
    required this.userId,
    this.dateCreated,
  });

  @override
  List<Object?> get props => [email, name, userId, dateCreated];
}
