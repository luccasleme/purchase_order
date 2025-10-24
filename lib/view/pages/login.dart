import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';
import 'package:purchase_order/core/utils/size.dart';
import 'package:purchase_order/view/pages/signup.dart';
import 'package:purchase_order/view/widgets/common/bottombanner.dart';
import 'package:purchase_order/view/widgets/page_exclusive/login_widgets.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return authState.showSignUp
        ? const SignUpPage()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: Screen.height(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const LoginLogo(),
                    Column(
                      children: [
                        LoginTextfield(
                          label: 'Email',
                          controller: authNotifier.emailController,
                        ),
                        LoginTextfield(
                          label: 'Password',
                          controller: authNotifier.passwordController,
                          hasSuffix: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RememberMeCheckbox(),
                              TextButton(
                                onPressed: () {
                                  authNotifier.toggleSignUp();
                                },
                                child: const Text(
                                  'Create an account',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 100, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoginButton()
                      ],
                    ),
                    const Spacer(),
                    const BottomBanner(),
                  ],
                ),
              ),
            ),
          );
  }
}
