import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/view/pages/signup.dart';
import 'package:purchase_order/view/widgets/common/textfield.dart';
import 'package:purchase_order/view/widgets/page_exclusive/login_widgets.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
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
                        RememberMeCheckbox(),
                        TextButton(
                            onPressed: () {
                              Get.off(() => SignUpPage());
                            },
                            child: Text(
                              'Criar uma conta',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 100, 1)),
                            )),
                      ],
                    ),
                  ),
                  LoginButton()
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
