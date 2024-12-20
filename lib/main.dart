import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/helpers/database.dart';
import 'package:purchase_order/helpers/theme.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  db = FirebaseFirestore.instance;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final controller = Get.put(
    LoginController(),
  );

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      theme: myTheme,
    );
  }
}
