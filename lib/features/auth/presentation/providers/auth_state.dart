import 'package:equatable/equatable.dart';
import 'package:purchase_order/features/auth/domain/entities/user_entity.dart';

class _Undefined {
  const _Undefined();
}

class AuthState extends Equatable {
  final UserEntity? user;
  final bool showSignUp;
  final bool isChecked;
  final bool isPasswordVisible;
  final bool isLoading;
  final String errorMessage;

  const AuthState({
    this.user,
    this.showSignUp = false,
    this.isChecked = false,
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage = '',
  });

  AuthState copyWith({
    Object? user = const _Undefined(),
    bool? showSignUp,
    bool? isChecked,
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user == const _Undefined() ? this.user : user as UserEntity?,
      showSignUp: showSignUp ?? this.showSignUp,
      isChecked: isChecked ?? this.isChecked,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        user,
        showSignUp,
        isChecked,
        isPasswordVisible,
        isLoading,
        errorMessage,
      ];
}
