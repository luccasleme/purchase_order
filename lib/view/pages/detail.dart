import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/detail_controller.dart';
import 'package:purchase_order/controller/home_controller.dart';
import 'package:purchase_order/utils/date_formater.dart';
import 'package:purchase_order/utils/size.dart';

class TaskDetail extends StatelessWidget {
  final int i;
  final int index;
  final DetailController controller = Get.put(DetailController());
  final HomeController homeController = Get.find();
  TaskDetail({required this.i, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: controller,
      builder: (_) {
        final keys = homeController.searchHomeList.keys.toList();
        keys.sort((a, b) => a.length.compareTo(b.length));
        final orderList = homeController.searchHomeList[keys[i]] ?? [];
        final order = orderList[index];
        statusFormat() {
          if (order.status.contains('/')) {
            final List<String> pBpR = order.status.split('/');
            final status = '${pBpR[0]}/\n${pBpR[1]}';
            return status;
          } else {
            return order.status;
          }
        }

        return Scaffold(
          appBar: AppBar(
            leading: controller.loading.value ? Container() : null,
            title: Text(order.vendorName),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order status: ',
                                  style: TextStyle(
                                      fontSize: Screen.width(context) / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  statusFormat(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: Screen.width(context) / 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Text(dateFormater(order.date),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Gap(4),
                        Row(
                          children: [
                            Text('Qty ordered: ',
                                style: TextStyle(
                                    fontSize: Screen.width(context) / 25,
                                    fontWeight: FontWeight.bold)),
                            Text('${order.quantityOrdered}.',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: Screen.width(context) / 25,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Text(
                          '\n\nVendor Name: ${order.vendorName}.\nVendor Entity ID: ${order.vendorEntityId}.\nDocument Number: ${order.documentNumber}.',
                          style:
                              TextStyle(fontSize: Screen.width(context) / 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '\n\n\nQty Billed: ${order.quantityBilled.toString()}.'),
                            Text(
                                '\n\n\nQty Received: ${order.quantityReceived.toString()}.'),
                          ],
                        ),
                        Gap(Screen.height(context) / 3),
                        !(order.status == 'Closed')
                            ? Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    controller.deny(order);
                                  },
                                  child: Text('Close'),
                                ),
                              )
                            : Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    controller.open(order);
                                  },
                                  child: Text('Open'),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
