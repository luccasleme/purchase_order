import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/home_controller.dart';
import 'package:purchase_order/controller/task_controller.dart';
import 'package:purchase_order/utils/date_formater.dart';
import 'package:purchase_order/utils/size.dart';
import 'package:purchase_order/view/widgets/page_exclusive/task_widgets.dart';

class TaskListPage extends StatelessWidget {
  final String title;
  final int i;
  final taskController = Get.put(TaskController());
  final HomeController homeController = Get.find();
  TaskListPage({required this.title, required this.i, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        final keys = homeController.searchHomeList.keys.toList();
        keys.sort((a, b) => a.length.compareTo(b.length));

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  homeController.resetSearch();
                  taskController.searchController.text = '';
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios)),
            title: TaskSearch(
              index: i,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [],
          ),
          body: Column(
            children: [
              Container(
                color: Color.fromRGBO(0, 45, 114, 1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$title Orders',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.searchHomeList[keys[i]].length,
                  itemBuilder: (context, index) {
                    final orderList = homeController.searchHomeList[keys[i]];
                    final order = orderList[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 4,
                              right: 4,
                              bottom: 4,
                              top: index == 0 ? 4 : 0),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 45, 114, 0.35),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 4),
                            leading: SizedBox(
                              width: Screen.width(context) / 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'ID:',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 200, 1),
                                      fontSize: Screen.width(context) / 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      order.documentNumber,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Screen.width(context) / 30,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              order.vendorName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Screen.width(context) / 25,
                                  color: Colors.black),
                            ),
                            trailing: Text(
                              dateFormater(order.date),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Screen.width(context) / 32,
                              ),
                            ),
                            onTap: () {
                              taskController.toDetail(i, index);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
