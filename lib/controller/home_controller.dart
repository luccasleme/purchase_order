import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purchase_order/model/order_model.dart';
import 'package:purchase_order/utils/database.dart';
import 'package:purchase_order/model/user_model.dart';
import 'package:purchase_order/view/pages/login.dart';
import 'package:purchase_order/view/pages/task.dart';
import 'package:purchase_order/view/widgets/common/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late Map<String, List<OrderModel>> ordersByStatus;
  late RxMap<String, dynamic> searchHomeList;

  Rx<UserModel>? user;
  List<OrderModel> homeList = <OrderModel>[].obs;
  List<String> quantity = <String>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<bool> loading = false.obs;
  late SharedPreferences prefs;

  @override
  void onInit() async {
    ordersByStatus = {};
    searchHomeList = <String, dynamic>{}.obs;
    getOrders();
    setPrefs();
    super.onInit();
  }

//GETS ALL THE ORDERS AND ORGANIZES THEM

  Future<Map<String, dynamic>> getOrders() async {
    try {
      loading.value = true;
      final doc = await db.collection("orders").doc("allOrders").get();
      final data = doc.data() as Map<String, dynamic>;

      for (var i = 0; i < data['allOrders'].length; i++) {
        homeList.add(
          OrderModel.fromMap(data['allOrders'][i]),
        );
      }

      ordersByStatus = groupOrdersByStatus(homeList);

      searchHomeList.value = groupOrdersByStatus(homeList);

      loading.value = false;
      refresh();
      return ordersByStatus;
    } on FirebaseException catch (e) {
      Alert.error(e.message ?? 'Unknown Error');
      return {};
    }
  }

  resetSearch() {
    searchHomeList.value = groupOrdersByStatus(homeList);
    refresh();
  }

//LOGOUT
  logOut() async {
    auth.signOut();
    prefs.remove('username');
    prefs.remove('password');
    prefs.setBool('remember', false);
    toLogin();
  }

//SIMPLE NAVIGATION
  toTaskList(String title, int i) {
    Get.to(
      () => TaskListPage(title: title, i: i),
    );
  }

  List<OrderModel>? search(String key, String text, List<OrderModel> list) {
    text = text.toLowerCase();
    var newList = <OrderModel>[];
    if (text == '') {
      newList = groupOrdersByStatus(homeList)[key] ?? [];
      refresh();
      return null;
    } else {
      for (var order in list) {
        String toString = (order.date.toString() +
                order.documentNumber +
                order.status +
                order.quantityBilled.toString() +
                order.quantityOrdered.toString() +
                order.quantityReceived.toString() +
                order.vendorEntityId +
                order.vendorName)
            .toLowerCase();
        toString.contains(text) ? newList.add(order) : null;
      }
      searchHomeList[key] = newList;
      refresh();
      return newList;
    }
  }

  toLogin() => Get.offAll(() => LoginPage());

  //SETS UP SHARED PREFERENCES
  setPrefs() async => prefs = await SharedPreferences.getInstance();

  //GROUPS A LIST OF ORDERS INTO A MAP OF ORDERS_STATUS : ORDERS
  Map<String, List<OrderModel>> groupOrdersByStatus(List<OrderModel> orders) {
    Map<String, List<OrderModel>> groupedOrders = {};

    for (var order in orders) {
      groupedOrders.putIfAbsent(order.status, () => []);
      groupedOrders[order.status]!.add(order);
    }

    return groupedOrders;
  }
}
