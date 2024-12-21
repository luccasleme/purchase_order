import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/order_model.dart';
import 'package:purchase_order/helpers/database.dart';
import 'package:purchase_order/view/pages/home.dart';

class DetailController extends GetxController {
  Rx<dynamic> taskId = ''.obs;
  Rx<String> detail = ''.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> reproving = false.obs;
  Rx<OrderModel> detailOrder = OrderModel.mock().obs;

  syncOrder(OrderModel order) {
    final docRef = db.collection("orders").doc("allOrders");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final orderFromDb = OrderModel.fromMap(data['orders']
            .where(
                (element) => element['documentNumber'] == order.documentNumber)
            .toList()[0]);
        detailOrder.value = orderFromDb;
      },
    );
  }

  @override
  void onInit() {
    reproving.value = false;

    super.onInit();
  }

//PEGA HTML DA APROVAÇÃO
  deny(OrderModel order) async {
    loading.value = true;
    refresh();
    final updatedOrder = OrderModel(
      date: order.date,
      documentNumber: order.documentNumber,
      status: 'Closed',
      quantityOrdered: order.quantityOrdered,
      vendorEntityId: order.vendorEntityId,
      vendorName: order.vendorName,
      quantityBilled: order.quantityBilled,
      quantityReceived: order.quantityReceived,
    );
    final document = db.collection('orders').doc('ordersById');
    await document.get().then(
      (DocumentSnapshot doc) {
        Map<String, dynamic> newMap =
            (doc.data() as Map<String, dynamic>)['ordersById'][0];
        newMap[order.documentNumber] = OrderModel.toMap(updatedOrder);
        db
            .collection('orders')
            .doc('allOrders')
            .set({'allOrders': newMap.values.toList()}).then(
          (e) async {
            await document.get().then(
              (DocumentSnapshot doc) {
                var newMap =
                    (doc.data() as Map<String, dynamic>)['ordersById'][0];
                newMap[order.documentNumber] = OrderModel.toMap(updatedOrder);
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

  aprove(OrderModel order) async {
    syncOrder(order);
  }
}
