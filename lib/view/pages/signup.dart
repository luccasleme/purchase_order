import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';
import 'package:purchase_order/core/utils/size.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/widgets/common/bottombanner.dart';
import 'package:purchase_order/view/widgets/page_exclusive/login_widgets.dart';
import 'package:purchase_order/view/widgets/page_exclusive/signup_widgets.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return !authState.showSignUp
        ? const LoginPage()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SizedBox(
                height: Screen.height(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const LoginLogo(),
                    Column(
                      children: [
                        SignUpTextfield(
                          label: 'Name',
                          controller: authNotifier.nameController,
                        ),
                        SignUpTextfield(
                          label: 'Email',
                          controller: authNotifier.emailController,
                        ),
                        SignUpTextfield(
                          label: 'Password',
                          controller: authNotifier.passwordController,
                          hasSuffix: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Gap(0),
                              TextButton(
                                onPressed: () {
                                  authNotifier.toggleSignUp();
                                },
                                child: const Text(
                                  'Already have an account.',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 100, 1)),
                                ),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromRGBO(0, 45, 114, 1),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: authState.isLoading
                              ? null
                              : () async {
                                  await authNotifier.signUp();
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
                              : const Text('Sign Up'),
                        ),
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
