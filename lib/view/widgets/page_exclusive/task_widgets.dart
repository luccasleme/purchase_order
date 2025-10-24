import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchase_order/features/orders/presentation/providers/orders_notifier.dart';
import 'package:purchase_order/core/utils/size.dart';

class TaskSearch extends ConsumerWidget {
  final int index;
  final TextEditingController searchController;

  const TaskSearch({
    required this.index,
    required this.searchController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersProvider);
    final ordersNotifier = ref.read(ordersProvider.notifier);

    final keys = ordersState.ordersByStatus.keys.toList();
    keys.sort((a, b) => a.length.compareTo(b.length));

    void search() {
      if (keys.length > index) {
        final originalList = ordersState.ordersByStatus[keys[index]] ?? [];
        ordersNotifier.search(
          keys[index],
          searchController.text,
          originalList,
        );
      }
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(200),
        ),
        width: Screen.width(context) / 1.45,
        height: Screen.height(context) / 22,
        child: TextField(
          controller: searchController,
          onChanged: (_) => search(),
          decoration: const InputDecoration(
            label: Text('Search'),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 13, bottom: 13),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
