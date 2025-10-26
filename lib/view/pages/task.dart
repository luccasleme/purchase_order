import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchase_order/features/orders/presentation/providers/orders_notifier.dart';
import 'package:purchase_order/core/utils/date_formatter.dart';
import 'package:purchase_order/core/utils/size.dart';
import 'package:purchase_order/routes/app_routes.dart';
import 'package:purchase_order/view/widgets/page_exclusive/task_widgets.dart';

class TaskListPage extends ConsumerStatefulWidget {
  final String title;
  final int i;

  const TaskListPage({required this.title, required this.i, super.key});

  @override
  ConsumerState<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(ordersProvider);
    final ordersNotifier = ref.read(ordersProvider.notifier);

    final keys = ordersState.searchResults.keys.toList();
    keys.sort((a, b) => a.length.compareTo(b.length));

    final orderList = keys.length > widget.i
        ? (ordersState.searchResults[keys[widget.i]] ?? [])
        : [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            ordersNotifier.resetSearch(null);
            searchController.text = '';
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: TaskSearch(
          index: widget.i,
          searchController: searchController,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(0, 45, 114, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.title} Orders',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: orderList.isEmpty
                ? const Center(
                    child: Text('No orders found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      final order = orderList[index];
                      return Container(
                        margin: EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 4,
                          top: index == 0 ? 4 : 0,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 45, 114, 0.35),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                    color: const Color.fromRGBO(0, 0, 200, 1),
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
                                      color: Colors.black,
                                    ),
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
                              color: Colors.black,
                            ),
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
                            context.push(
                              AppRoutes.detail,
                              extra: {
                                'i': widget.i,
                                'index': index,
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
