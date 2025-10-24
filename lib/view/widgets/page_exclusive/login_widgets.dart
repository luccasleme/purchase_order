import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';
import 'package:purchase_order/core/utils/size.dart';

class RememberMeCheckbox extends ConsumerWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Row(
      children: [
        const Gap(16),
        Checkbox(
          activeColor: const Color.fromRGBO(0, 153, 51, 1),
          value: authState.isChecked,
          onChanged: (value) {
            authNotifier.toggleCheckbox(value!);
          },
        ),
        const Text('Remember me')
      ],
    );
  }
}

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: SizedBox(
        width: Screen.width(context) / 1.5,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            'Purchase Order\nManagment',
            style: TextStyle(
                //fontSize: Screen.width(context) / 15,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(0, 45, 114, 1),
        foregroundColor: Colors.white,
      ),
      onPressed: authState.isLoading
          ? null
          : () async {
              await authNotifier.signIn();
            },
      child: authState.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Text('Login'),
    );
  }
}

class LoginTextfield extends ConsumerWidget {
  final TextEditingController? controller;
  final bool? hasSuffix;
  final bool? isPass;
  final String? label;

  const LoginTextfield({
    this.label,
    this.controller,
    this.isPass,
    this.hasSuffix,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Container(
      margin: const EdgeInsets.only(bottom: 4, right: 24, left: 24),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 45, 114, 0.2),
          borderRadius: BorderRadius.circular(4)),
      child: TextField(
        controller: controller,
        obscureText: (hasSuffix ?? false)
            ? !authState.isPasswordVisible
            : (isPass ?? false),
        decoration: InputDecoration(
          suffixIcon: (hasSuffix ?? false)
              ? IconButton(
                  onPressed: () {
                    authNotifier.togglePasswordVisibility();
                  },
                  icon: Icon(
                    authState.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                )
              : null,
          floatingLabelStyle:
              const TextStyle(color: Color.fromRGBO(0, 45, 114, 1)),
          contentPadding: const EdgeInsets.only(left: 8),
          border: InputBorder.none,
          label: Text(label ?? ''),
        ),
      ),
    );
  }
}
