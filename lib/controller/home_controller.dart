import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/order_model.dart';
import 'package:purchase_order/helpers/database.dart';
import 'package:purchase_order/model/task_model.dart';
import 'package:purchase_order/model/user_model.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/pages/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  Rx<UserModel>? user;
  List<OrderModel> homeList = <OrderModel>[].obs;
  List<TaskModel> taskList = <TaskModel>[].obs;
  List<String> quantity = <String>[].obs;
  List<OrderModel> open = [];
  List<OrderModel> closed = [];
  List<OrderModel> fullyBilled = [];
  List<OrderModel> pendingBill = [];
  List<OrderModel> partiallyReceived = [];
  List<OrderModel> pBpR = [];
  List<List<OrderModel>> ordersByStatus = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<bool> loading = false.obs;
  late SharedPreferences prefs;

  @override
  void onInit() async {
    setOrderByStatusList();
    getOrders();
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

//PEGA OS PROCESSOS

  getOrders() async {
    final docAllOrders = db.collection("orders").doc("allOrders");
    docAllOrders.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        for (var i = 0; i < data['allOrders'].length; i++) {
          homeList.add(
            OrderModel.fromMap(data['allOrders'][i]),
          );
        }

        for (var order in homeList) {
          loading.value = true;
          refresh();
          if (order.status == 'Open') {
            open.add(order);
          }

          if (order.status == 'Closed') {
            closed.add(order);
          }
          if (order.status == 'Fully Billed') {
            fullyBilled.add(order);
          }
          if (order.status == 'Pending Bill') {
            pendingBill.add(order);
          }
          if (order.status == 'Partially Received') {
            partiallyReceived.add(order);
          }
          if (order.status == 'Pending Billing/Partially Received') {
            pBpR.add(order);
          }
          loading.value = false;
          refresh();
        }
        loading.value = false;
        refresh();
      },
      onError: (e) => print("Error getting document: $e"),
    );
    loading.value = false;
    refresh();
  }

  setOrderByStatusList() {
    ordersByStatus.add(open);
    ordersByStatus.add(closed);
    ordersByStatus.add(fullyBilled);
    ordersByStatus.add(pendingBill);
    ordersByStatus.add(partiallyReceived);
    ordersByStatus.add(pendingBill);
  }

//LOGOUT
  logOut() async {
    auth.signOut();
    prefs.remove('username');
    prefs.remove('password');
    prefs.setBool('remember', false);
    toLogin();
  }

//Navegação
  toTaskList(String title, int i) {
    Get.to(
      () => TaskListPage(
        title: title,
        i: i,
      ),
    );
  }
}

toLogin() {
  Get.offAll(() => LoginPage());
}
