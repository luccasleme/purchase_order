import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/signup_controller.dart';

class SignUpTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isPass;
  final bool? isConfirm;
  final bool? hasSuffix;
  final String? label;
  final SignUpController signUpController = Get.find();
  SignUpTextfield(
      {this.label,
      this.controller,
      this.hasSuffix,
      this.isPass,
      this.isConfirm,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (_) {
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
                        signUpController.toggleShowPassword(isConfirm);
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
      },
    );
  }
}
