import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/model/user_model.dart';
import 'package:purchase_order/view/pages/home.dart';
import 'package:purchase_order/view/widgets/common/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Rx<UserModel> user = UserModel(name: '', email: '', userId: '').obs;
  final auth = FirebaseAuth.instance;
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  var errorMessage = ''.obs;
  var isChecked = false.obs;
  Rx<bool> isPass = true.obs;
  late SharedPreferences prefs;

  @override
  onInit() async {
    prefs = await SharedPreferences.getInstance();
    errorMessage.value = '';
    rememberLogin();
    super.onInit();
  }

//FAZ COM QUE O CHECKBOX SEJA RESPONSIVO
  void toggleCheckbox(bool value) {
    isChecked.value = value;
    refresh();
  }

//FAZ LOGIN NO APP
  logIn(String user, String password) async {
    if (user.isEmpty || password.isEmpty) {
      errorMessage.value = 'Preencha usuário e senha por favor';
      return;
    }

    try {
      await auth.signInWithEmailAndPassword(
          email: user.trimLeft().trimRight(), password: password);
      isChecked.value
          ? {
              prefs.setBool('remember', isChecked.value),
              prefs.setString('username', user),
              prefs.setString('password', password),
              Get.showSnackbar(Alert.aproved(
                  title: 'Sucesso:', message: 'Logged in successfully.')),
            }
          : {
              Get.showSnackbar(
                Alert.aproved(
                  title: 'Sucess:',
                  message: 'Logged in successfully.',
                ),
              ),
              getUser(user),
            };
      Get.off(() => HomePage());
      errorMessage.value = '';
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Unknown error.';
      Get.showSnackbar(
        Alert.error(title: 'Erro:', message: errorMessage.value),
      );
    } catch (e) {
      e.toString().startsWith(
              'ClientException with SocketException: Failed host lookup:')
          ? errorMessage.value = 'Sem acesso à internet.'
          : errorMessage.value = 'Unknown error.';
      Alert.error(
        title: 'Erro:',
        message: errorMessage.value,
      );
    }
  }

  getUser(String email) async {
    user.value = await UserModel.userFromDB(email);
  }
//

//FUNÇÃO LEMBRAR DE MIM

  rememberLogin() async {
    final rememberMe = prefs.getBool('remember');
    final user = prefs.getString('username');
    final pass = prefs.getString('password');
    rememberMe != null
        ? {
            rememberMe == true ? {logIn(user!, pass!)} : null
          }
        : null;
  }

  togglePassword() {
    isPass.value = !isPass.value;
    refresh();
  }
}
