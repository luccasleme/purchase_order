import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_order/utils/database.dart';
import 'package:purchase_order/view/pages/home.dart';
import 'package:purchase_order/model/user_model.dart';
import 'package:purchase_order/view/widgets/common/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  late SharedPreferences prefs;
  var isPass = true.obs;
  var isConfirmPass = true.obs;
  Rx<String> errorMessage = ''.obs;

  @override
  onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  toggleShowPassword(bool? isConfirm) {
    (isConfirm ?? false)
        ? {isConfirmPass.value = !isConfirmPass.value}
        : {isPass.value = !isPass.value};
    refresh();
  }

  signUp(String name, String email, String password, String confirmPass) async {
    if (fieldChecker(name, email, password, confirmPass)) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          try {
            final String userId = value.user!.uid;
            final UserModel userModel =
                UserModel(email: email, userId: userId, name: name);
            final Map<String, dynamic> newUser = UserModel.toMap(userModel);
            db.collection("users").add(newUser);
          } on FirebaseException catch (e) {
            errorMessage.value = e.message ?? 'Unknown error.';

            Alert.error(errorMessage.value);
          } catch (e) {
            errorMessage.value = e.toString();

            Alert.error(errorMessage.value);
          }

          prefs.setString('username', email);
          Get.off(() => HomePage());
          Alert.success('Account created successfully');
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          errorMessage.value = 'The password provided is too weak.';

          Alert.error(errorMessage.value);
        } else if (e.code == 'email-already-in-use') {
          errorMessage.value = 'The account already exists for that email.';

          Alert.error(errorMessage.value);
        }
      } catch (e) {
        errorMessage.value = 'Unknown error.';

        Alert.error(errorMessage.value);
      }
    } else {
      Alert.error(errorMessage.value);
    }
  }

  bool fieldChecker(
      String name, String email, String password, String confirmPass) {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPass.isEmpty) {
      errorMessage.value = 'All fields are required.';
      return false;
    }
    if (password != confirmPass) {
      errorMessage.value = 'Passwords should match';
      return false;
    }
    return true;
  }
}
