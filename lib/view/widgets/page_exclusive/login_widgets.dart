import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/utils/size.dart';

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
          const Text('Remember me')
        ],
      ),
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
        onPressed: () async {
          controller.logIn(
            controller.userController.text,
            controller.passwordController.text,
          );
        },
        child: const Text('Login'),
      ),
    );
  }
}

class LoginTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final bool? hasSuffix;
  final bool? isPass;
  final String? label;
  final LoginController loginController = Get.find();
  LoginTextfield(
      {this.label, this.controller, this.isPass, this.hasSuffix, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4, right: 24, left: 24),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 45, 114, 0.2),
          borderRadius: BorderRadius.circular(4)),
      child: TextField(
        controller: controller,
        obscureText: isPass ?? false,
        decoration: InputDecoration(
          suffixIcon: (hasSuffix ?? false)
              ? IconButton(
                  onPressed: () {
                    loginController.togglePassword();
                  },
                  icon: Icon(Icons.remove_red_eye),
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

