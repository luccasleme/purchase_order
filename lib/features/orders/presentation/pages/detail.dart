import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:purchase_order/core/utils/date_formatter.dart';
import 'package:purchase_order/core/utils/size.dart';
import 'package:purchase_order/features/orders/presentation/providers/orders_notifier.dart';
import 'package:purchase_order/routes/app_routes.dart';

class TaskDetail extends ConsumerWidget {
  final int i;
  final int index;

  const TaskDetail({required this.i, required this.index, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersProvider);
    final ordersNotifier = ref.read(ordersProvider.notifier);

    final keys = ordersState.searchResults.keys.toList();
    keys.sort((a, b) => a.length.compareTo(b.length));
    final orderList = keys.length > i ? (ordersState.searchResults[keys[i]] ?? []) : [];

    if (orderList.isEmpty || index >= orderList.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Detail'),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Text('Order not found'),
        ),
      );
    }

    final order = orderList[index];

    String statusFormat() {
      if (order.status.contains('/')) {
        final List<String> pBpR = order.status.split('/');
        return '${pBpR[0]}/\n${pBpR[1]}';
      } else {
        return order.status;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: ordersState.isLoading ? Container() : null,
        title: Text(order.vendorName),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ordersState.isLoading
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
                    const Gap(4),
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
                      style: TextStyle(fontSize: Screen.width(context) / 25),
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
                              onPressed: () async {
                                await ordersNotifier.closeOrder(order);
                                if (context.mounted) {
                                  context.go(AppRoutes.home);
                                }
                              },
                              child: const Text('Close'),
                            ),
                          )
                        : Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                await ordersNotifier.openOrder(order);
                                if (context.mounted) {
                                  context.go(AppRoutes.home);
                                }
                              },
                              child: const Text('Open'),
                            ),
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
