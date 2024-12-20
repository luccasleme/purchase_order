import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/signup_controller.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/widgets/common/textfield.dart';
import 'package:purchase_order/view/widgets/page_exclusive/login_widgets.dart';

class SignUpPage extends StatelessWidget {
  final controller = Get.put(SignUpController());
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
                  AppTextfield(
                    label: 'Usuário',
                    controller: controller.userController,
                  ),
                  AppTextfield(
                    label: 'Senha',
                    controller: controller.passwordController,
                    isPass: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Gap(0),
                        TextButton(
                          onPressed: () {
                            Get.off(LoginPage());
                          },
                          child: Text(
                            'Já tenho conta.',
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
                      controller
                          .signUp(
                        controller.userController.text,
                        controller.passwordController.text,
                      )
                          .then(
                        (_) {
                          controller.errorMessage.value != ''
                              ? Get.snackbar(
                                  'Error:',
                                  controller.errorMessage.value,
                                  colorText: Colors.white,
                                  backgroundColor:
                                      const Color.fromRGBO(204, 0, 51, 1),
                                )
                              : null;
                        },
                      );
                    },
                    child: const Text('Cadastrar'),
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
