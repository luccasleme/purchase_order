import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/home_controller.dart';
import 'package:purchase_order/controller/task_controller.dart';
import 'package:purchase_order/utils/size.dart';

class TaskSearch extends StatelessWidget {
  final int index;
  final TaskController taskController = Get.find();
  final HomeController homeController = Get.find();
  TaskSearch({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final keys = homeController.searchHomeList.keys.toList();
    keys.sort((a, b) => a.length.compareTo(b.length));
    search() {
      homeController.resetSearch();
      homeController.search(
        keys[index],
        taskController.searchController.text,
        homeController.searchHomeList[keys[index]],
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(200)),
        width: Screen.width(context) / 1.45,
        height: Screen.height(context) / 22,
        child: TextField(
          controller: taskController.searchController,
          onChanged: (_) => search(),
          decoration: InputDecoration(
            label: Text('Search'),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 13, bottom: 13),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
