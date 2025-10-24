import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchase_order/core/constants/app_constants.dart';
import 'package:purchase_order/core/providers/providers.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_state.dart';
import 'package:purchase_order/view/widgets/common/alert.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  AuthNotifier(this.ref) : super(const AuthState()) {
    _checkAutoLogin();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> _checkAutoLogin() async {
    state = state.copyWith(isLoading: true);

    final getSavedCredentials = ref.read(getSavedCredentialsProvider);
    final credentialsResult = await getSavedCredentials();

    credentialsResult.fold(
      (failure) {
        state = state.copyWith(isLoading: false);
      },
      (credentials) async {
        final email = credentials['email'] ?? '';
        final password = credentials['password'] ?? '';

        if (email.isNotEmpty && password.isNotEmpty) {
          await signIn(email: email, password: password, autoLogin: true);
        } else {
          state = state.copyWith(isLoading: false);
        }
      },
    );
  }

  void toggleCheckbox(bool value) {
    state = state.copyWith(isChecked: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleSignUp() {
    state = state.copyWith(
      showSignUp: !state.showSignUp,
      errorMessage: '',
    );
  }

  Future<void> signIn({
    String? email,
    String? password,
    bool autoLogin = false,
  }) async {
    final loginEmail = email ?? emailController.text.trim();
    final loginPassword = password ?? passwordController.text;

    if (loginEmail.isEmpty || loginPassword.isEmpty) {
      state = state.copyWith(errorMessage: AppConstants.fillFieldsError);
      Alert.error(state.errorMessage);
      return;
    }

    state = state.copyWith(isLoading: true);

    final signIn = ref.read(signInProvider);
    final result = await signIn(
      email: loginEmail,
      password: loginPassword,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        Alert.error(state.errorMessage);
      },
      (user) async {
        state = state.copyWith(
          user: user,
          errorMessage: '',
          isLoading: false,
        );

        if (state.isChecked && !autoLogin) {
          final saveCredentials = ref.read(saveCredentialsProvider);
          await saveCredentials(
            email: loginEmail,
            password: loginPassword,
          );
        }

        Alert.success('Logged In Successfully!');
      },
    );
  }

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      state = state.copyWith(errorMessage: 'All fields are required.');
      Alert.error(state.errorMessage);
      return;
    }

    state = state.copyWith(isLoading: true);

    final signUp = ref.read(signUpProvider);
    final result = await signUp(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        Alert.error(state.errorMessage);
      },
      (_) {
        state = state.copyWith(errorMessage: '', isLoading: false);
        Alert.success('Account created successfully!');
        toggleSignUp();
        emailController.clear();
        passwordController.clear();
        nameController.clear();
      },
    );
  }

  Future<void> signOut() async {
    final signOut = ref.read(signOutProvider);
    final result = await signOut();

    result.fold(
      (failure) {
        Alert.error(failure.message);
      },
      (_) async {
        final clearCredentials = ref.read(clearCredentialsProvider);
        await clearCredentials();
        state = state.copyWith(user: null);
      },
    );
  }

  Future<void> getUserByEmail(String email) async {
    final getUser = ref.read(getUserProvider);
    final result = await getUser(email);

    result.fold(
      (failure) {
        Alert.error(failure.message);
      },
      (user) {
        state = state.copyWith(user: user);
      },
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
