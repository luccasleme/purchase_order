import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:purchase_order/model/order_model.dart';
import 'package:purchase_order/utils/database.dart';
import 'package:purchase_order/view/pages/home.dart';

class DetailController extends GetxController {
  Rx<dynamic> taskId = ''.obs;
  Rx<String> detail = ''.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> reproving = false.obs;

  @override
  void onInit() {
    reproving.value = false;
    super.onInit();
  }

  deny(OrderModel order) async {
    loading.value = true;
    refresh();
    order.status = 'Closed';
    final docRef = db.collection('orders').doc('ordersById');
    await docRef.get().then(
      (DocumentSnapshot doc) {
        Map<String, dynamic> newMap =
            (doc.data() as Map<String, dynamic>)['ordersById'][0];
        newMap[order.documentNumber] = OrderModel.toMap(order);
        db
            .collection('orders')
            .doc('allOrders')
            .set({'allOrders': newMap.values.toList()}).then(
          (e) async {
            await docRef.get().then(
              (DocumentSnapshot doc) {
                var newMap =
                    (doc.data() as Map<String, dynamic>)['ordersById'][0];
                newMap[order.documentNumber] = OrderModel.toMap(order);
              },
            );
            db.collection('orders').doc('ordersById').set({
              'ordersById': [newMap]
            });
          },
        );
      },
    );
    loading.value = false;
    Get.offAll(() => HomePage());
  }

  open(OrderModel order) async {
    loading.value = true;
    refresh();
    order.status = 'Open';

    final document = db.collection('orders').doc('ordersById');

    await document.get().then(
      (DocumentSnapshot doc) {
        Map<String, dynamic> newMap =
            (doc.data() as Map<String, dynamic>)['ordersById'][0];
        newMap[order.documentNumber] = OrderModel.toMap(order);
        db
            .collection('orders')
            .doc('allOrders')
            .set({'allOrders': newMap.values.toList()}).then(
          (e) async {
            await document.get().then(
              (DocumentSnapshot doc) {
                var newMap =
                    (doc.data() as Map<String, dynamic>)['ordersById'][0];
                newMap[order.documentNumber] = OrderModel.toMap(order);
              },
            );
            db.collection('orders').doc('ordersById').set({
              'ordersById': [newMap]
            });
          },
        );
      },
    );
    loading.value = false;
    Get.offAll(() => HomePage());
  }
}
