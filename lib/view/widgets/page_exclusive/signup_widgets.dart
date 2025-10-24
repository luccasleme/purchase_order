import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';

class SignUpTextfield extends ConsumerWidget {
  final TextEditingController? controller;
  final bool? isPass;
  final bool? isConfirm;
  final bool? hasSuffix;
  final String? label;

  const SignUpTextfield({
    this.label,
    this.controller,
    this.hasSuffix,
    this.isPass,
    this.isConfirm,
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
