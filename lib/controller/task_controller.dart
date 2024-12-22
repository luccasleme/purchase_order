import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/order_model.dart';
import 'package:purchase_order/model/task_model.dart';
import 'package:purchase_order/view/pages/detail.dart';
import 'package:purchase_order/view/pages/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController extends GetxController {
  late SharedPreferences prefs;
  Rx<bool> reproving = false.obs;
  Rx<bool> isAllChecked = false.obs;
  List<TaskModel> taskList = <TaskModel>[].obs;
  List<OrderModel> filteredTaskList = <OrderModel>[].obs;
  List<bool> checkList = <bool>[].obs;
  List<String> forAproval = <String>[].obs;
  TextEditingController searchController = TextEditingController();
  Rx<bool> loading = false.obs;

  @override
  onInit() async {
    prefs = await SharedPreferences.getInstance();

    super.onInit();
  }

//PEGA AS APROVAÇÕES

  List<OrderModel>? search(String text, List<OrderModel> list) {
    text = text.toLowerCase();
    if (text == '') {
      refresh();
      return null;
    } else {
      var newList = <OrderModel>[];
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
      newList;
      refresh();

      return newList;
    }
  }

//NAVEGAÇÕES

  toTaskList(String title, int i) {
    Get.to(() => TaskListPage(
          title: title,
          i: i,
        ));
  }

  toDetail(int i, int index) {
    Get.to(() => TaskDetail(i: i, index: index));
  }
}
