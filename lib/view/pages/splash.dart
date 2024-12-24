import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/utils/theme.dart';

class SplashScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: myTheme.primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'PO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
