import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/controller/signup_controller.dart';
import 'package:purchase_order/utils/size.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/widgets/common/bottombanner.dart';
import 'package:purchase_order/view/widgets/page_exclusive/login_widgets.dart';
import 'package:purchase_order/view/widgets/page_exclusive/signup_widgets.dart';

class SignUpPage extends StatelessWidget {
  final signController = Get.put(SignUpController());
  final LoginController loginController = Get.find();
  final isPass = true.obs;
  final isConfirmPass = true.obs;
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (_) => !loginController.showSignUp.value
          ? LoginPage()
          : Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SizedBox(
                  height: Screen.height(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      const LoginLogo(),
                      Column(
                        children: [
                          SignUpTextfield(
                            label: 'Name',
                            controller: signController.nameController,
                          ),
                          SignUpTextfield(
                            label: 'Email',
                            controller: signController.userController,
                          ),
                          SignUpTextfield(
                            label: 'Password',
                            controller: signController.passwordController,
                            isPass: signController.isPass.value,
                            hasSuffix: true,
                          ),
                          SignUpTextfield(
                            label: 'Confirm Password',
                            controller:
                                signController.passwordConfirmController,
                            isPass: signController.isConfirmPass.value,
                            isConfirm: true,
                            hasSuffix: true,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Gap(0),
                                TextButton(
                                  onPressed: () {
                                    loginController.toggleSignUp();
                                  },
                                  child: Text(
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
                            onPressed: () {
                              signController.signUp(
                                signController.nameController.text,
                                signController.userController.text,
                                signController.passwordController.text,
                                signController.passwordConfirmController.text,
                              );
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                      Spacer(),
                      BottomBanner(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
