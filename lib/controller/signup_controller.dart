import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_order/helpers/database.dart';
import 'package:purchase_order/model/user_model.dart';
import 'package:purchase_order/view/pages/home.dart';
import 'package:purchase_order/view/widgets/common/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  Rx<String> errorMessage = ''.obs;

  @override
  onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  signUp(String user, String pass) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user,
        password: pass,
      )
          .then((value) async {
        try {
          final String userId = value.user!.uid;
          final UserModel userModel = UserModel(email: user, userId: userId);
          final Map<String, dynamic> newUser = UserModel.toMap(userModel);
          db.collection("users").add(newUser);
        } on FirebaseException catch (e) {
          errorMessage.value = e.message ?? 'Unknown error.';
        } catch (e) {
          errorMessage.value = e.toString();
        }

        prefs.setString('username', user);
        Get.off(() => HomePage());
        Alert.aproved(
          title: 'Success:',
          message: 'Account created successfully',
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage.value = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage.value = 'The account already exists for that email.';
      }
    } catch (e) {
      errorMessage.value = 'Unknown error.';
    }
  }
}
