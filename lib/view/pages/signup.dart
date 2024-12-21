import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/signup_controller.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/widgets/page_exclusive/login_widgets.dart';
import 'package:purchase_order/view/widgets/page_exclusive/signup_widgets.dart';

class SignUpPage extends StatelessWidget {
  final controller = Get.put(SignUpController());
  final isPass = true.obs;
  final isConfirmPass = true.obs;
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const LoginLogo(),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SignUpTextfield(
                    label: 'Name',
                    controller: controller.nameController,
                  ),
                  SignUpTextfield(
                    label: 'Email',
                    controller: controller.userController,
                  ),
                  SignUpTextfield(
                    label: 'Password',
                    controller: controller.passwordController,
                    isPass: controller.isPass.value,
                    hasSuffix: true,
                  ),
                  SignUpTextfield(
                    label: 'Confirm Password',
                    controller: controller.passwordConfirmController,
                    isPass: controller.isConfirmPass.value,
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
                            Get.off(() => LoginPage());
                          },
                          child: Text(
                            'Already have an account.',
                            style:
                                TextStyle(color: Color.fromRGBO(0, 0, 100, 1)),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color.fromRGBO(0, 45, 114, 1),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      controller.signUp(
                        controller.nameController.text,
                        controller.userController.text,
                        controller.passwordController.text,
                        controller.passwordConfirmController.text,
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Image.asset('assets/banner.png')),
          ],
        ),
      ),
    );
  }
}
