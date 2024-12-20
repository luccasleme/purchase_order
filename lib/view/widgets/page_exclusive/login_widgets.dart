
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/helpers/size.dart';

class RememberMeCheckbox extends StatelessWidget {
  final LoginController controller = Get.find();
  RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => Row(
        children: [
          const Gap(16),
          Checkbox(
            activeColor: const Color.fromRGBO(0, 153, 51, 1),
            value: controller.isChecked.value,
            onChanged: (value) {
              controller.toggleCheckbox(value!);
            },
          ),
          const Text('Lembrar de mim')
        ],
      ),
    );
  }
}

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Image.asset(
        'assets/logo.jpeg',
        width: Screen.width(context) / 1.5,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginController controller = Get.find();
  LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(0, 45, 114, 1),
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          controller
              .logIn(
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
                      backgroundColor: const Color.fromRGBO(204, 0, 51, 1),
                    )
                  : null;
            },
          );
        },
        child: const Text('Login'),
      ),
    );
  }
}
