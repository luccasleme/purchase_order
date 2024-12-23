import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/home_controller.dart';
import 'package:purchase_order/controller/login_controller.dart';
import 'package:purchase_order/controller/task_controller.dart';
import 'package:purchase_order/utils/size.dart';

class HomePage extends StatelessWidget {
  final LoginController loginController = Get.find();
  final homeController = Get.put(HomeController());
  final taskController = Get.put(TaskController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        String name = loginController.user.value.name;
        bool checker() {
          if (homeController.ordersByStatus[0].isEmpty ||
              homeController.ordersByStatus[1].isEmpty ||
              homeController.ordersByStatus[2].isEmpty ||
              homeController.ordersByStatus[3].isEmpty ||
              homeController.ordersByStatus[4].isEmpty ||
              homeController.ordersByStatus[5].isEmpty) {
            return true;
          } else {
            return false;
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                'Welcome, $name!',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
              ),
            ),
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
          body: checker()
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(0, 54, 114, 1),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns

                    crossAxisSpacing:
                        Screen.width(context) / 50, // Spacing between columns
                    mainAxisSpacing:
                        Screen.width(context) / 50, // Spacing between rows
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
                      'Pending Billing/\nPartially Received',
                    ];
                    final iconList = <IconData>[
                      Icons.mark_email_unread,
                      Icons.close,
                      Icons.done,
                      Icons.wallet,
                      Icons.payments,
                      Icons.receipt_long
                    ];

                    return InkWell(
                      onTap: () {
                        homeController.toTaskList(titleList[index], index);
                      },
                      child: GridTile(
                        header: Align(
                          alignment: Alignment.topRight,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                homeController.ordersByStatus[index].length
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: Screen.width(context) / 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              iconList[index],
                              size: Screen.width(context) / 5,
                              color: Color.fromRGBO(0, 0, 100, 1),
                            ),
                            FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                titleList[index],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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
