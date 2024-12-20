import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/home_controller.dart';
import 'package:purchase_order/controller/task_controller.dart';
import 'package:purchase_order/helpers/size.dart';

class HomePage extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final taskController = Get.put(TaskController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bem-Vindo!'),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                onPressed: () {
                  homeController.logOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromRGBO(204, 0, 51, 1),
                ),
              )
            ],
          ),
          body: homeController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(0, 54, 114, 1),
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    // crossAxisSpacing: 8.0, // Spacing between columns
                    // mainAxisSpacing: 8.0, // Spacing between rows
                  ),
                  //padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final titleList = <String>[
                      'Open',
                      'Closed',
                      'Fully Billed',
                      'Pending Bill',
                      'Partially Received',
                      'Pending Bill/Partially Received',
                    ];
                    final iconList = <IconData>[
                      Icons.mail,
                      Icons.close,
                      Icons.money,
                      Icons.pending,
                      Icons.receipt,
                      Icons.receipt_long
                    ];
                    return InkWell(
                      onTap: () {
                        homeController.toTaskList(titleList[index], index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          //borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(20),
                        child: GridTile(
                          header: Align(
                            alignment: Alignment.topRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: homeController
                                      .ordersByStatus[index].isNotEmpty
                                  ? Text(
                                      homeController
                                          .ordersByStatus[index].length
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: Screen.width(context) / 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                            ),
                          ),
                          footer: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              titleList[index],
                            ),
                          ),
                          child: Icon(
                            iconList[index],
                            size: Screen.width(context) / 4,
                            color: Color.fromRGBO(0, 0, 100, 1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
