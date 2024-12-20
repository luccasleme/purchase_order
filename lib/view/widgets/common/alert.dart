import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class Alert {
  static error({String? title, String? message}) {
    final errorSnackbar = GetSnackBar(
      backgroundColor: const Color.fromRGBO(204, 0, 51, 1),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      title: title,
      message: message,
      borderRadius: 15,
    );
    return errorSnackbar;
  }
  static aproved({String? title, String? message}) {
    final errorSnackbar = GetSnackBar(
      backgroundColor:  Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      title: title,
      message: message,
      borderRadius: 15,
    );
    return errorSnackbar;
  }
}
