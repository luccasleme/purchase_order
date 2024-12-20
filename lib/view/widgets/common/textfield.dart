import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isPass;
  final String? label;
  const AppTextfield({this.label, this.controller, this.isPass, super.key});

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
