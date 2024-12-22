
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:purchase_order/controller/detail_controller.dart';
import 'package:purchase_order/controller/task_controller.dart';
import 'package:purchase_order/utils/size.dart';

class Reason extends StatelessWidget {
  final bool isDetail;
  final TaskController taskController = Get.find();
  final DetailController detailController = Get.find();

  Reason({required this.isDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Screen.height(context) / 14),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Screen.height(context) / 14,
            color: const Color.fromRGBO(0, 45, 114, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Justifique',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Screen.width(context) / 20),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: Screen.height(context) / 3,
              child: const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Screen.width(context), 30),
                  elevation: 0,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white),
              onPressed: () {
                //isDetail
                    //? detailController.aprove(false)
                    //: taskController.aprove(false);
              },
              child: const Text(
                'Reprovar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

