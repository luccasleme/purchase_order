import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchase_order/controller/order_model.dart';
import 'package:purchase_order/utils/database.dart';
import 'package:purchase_order/view/widgets/common/alert.dart';

Future<Excel> importExcelFile() async {
  ByteData data = await rootBundle.load("assets/excel.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    print(excel.tables[table]!.maxColumns);
    print(excel.tables[table]!.maxRows);
    // for (var row in excel.tables[table]!.rows) {
    //   print("$row");
    // }
  }
  return excel;
}

void parseExcelToOrderModel() async {
  List<OrderModel> orders = [];

  // Assuming the sheet name is known, e.g., 'Orders'
  final Excel excel = await importExcelFile();
  var sheet = excel.tables['Purchase Order - CLASS']!;

  // Iterate over the rows (skip the header row)
  for (var i = 1; i < sheet.rows.length; i++) {
    var row = sheet.rows[i];

    try {
      // Parse the values from the row
      DateTime date = DateTime.parse(
          row[0]?.value.toString() ?? ''); // Ensure proper date format
      String documentNumber = row[1]?.value?.toString() ?? '';
      String status = row[2]?.value?.toString() ?? '';
      int quantityOrdered = int.tryParse(row[3]?.value?.toString() ?? '0') ?? 0;
      String vendorEntityId = row[4]?.value?.toString() ?? '';
      String vendorName = row[5]?.value?.toString() ?? '';
      int quantityBilled = int.tryParse(row[6]?.value?.toString() ?? '0') ?? 0;
      int quantityReceived =
          int.tryParse(row[7]?.value?.toString() ?? '0') ?? 0;

      // Add to the list of orders
      orders.add(
        OrderModel(
          date: date,
          documentNumber: documentNumber,
          status: status,
          quantityOrdered: quantityOrdered,
          vendorEntityId: vendorEntityId,
          vendorName: vendorName,
          quantityBilled: quantityBilled,
          quantityReceived: quantityReceived,
        ),
      );
    } catch (e) {
      print("Error parsing row $i: $e");
    }
  }

  try {
    final map = {
      for (var order in orders) order.documentNumber: OrderModel.toMap(order)
    };

    db.collection('orders').doc('ordersById').set({
      'ordersById': [map]
    });
  } on FirebaseException catch (e) {
    Get.showSnackbar(
      Alert.error(title: 'Error', message: e.message ?? 'Erro desconhecido.'),
    );
  } catch (e) {
    Alert.error(title: 'Error', message: e.toString());
  }
}
