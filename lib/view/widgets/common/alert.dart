import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  static error(String? message, {String? title}) {
    return Get.showSnackbar(
        Alert.errorSnackbar(title: title, message: message));
  }

  static success(String? message, {String? title}) {
    return Get.showSnackbar(Alert.successSnackBar(title: title, message));
  }

  static errorSnackbar({String? title, String? message}) {
    final errorSnackbar = GetSnackBar(
      backgroundColor: const Color.fromRGBO(204, 0, 51, 1),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      title: 'Error:',
      message: message ?? 'Unknown error.',
      borderRadius: 15,
    );
    return errorSnackbar;
  }

  static successSnackBar(String? message, {String? title}) {
    final errorSnackbar = GetSnackBar(
      backgroundColor: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      title: 'Success:',
      message: message ?? 'Success',
      borderRadius: 15,
    );
    return errorSnackbar;
  }
}
