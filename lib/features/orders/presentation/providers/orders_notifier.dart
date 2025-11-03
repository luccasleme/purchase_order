import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchase_order/core/presentation/widgets/alert.dart';
import 'package:purchase_order/core/providers/providers.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';
import 'package:purchase_order/features/orders/presentation/providers/orders_state.dart';

class OrdersNotifier extends StateNotifier<OrdersState> {
  final Ref ref;

  OrdersNotifier(this.ref) : super(const OrdersState()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true);

    final getOrdersByStatus = ref.read(getOrdersByStatusProvider);
    final result = await getOrdersByStatus();

    result.fold(
      (failure) {
        Alert.error(failure.message);
        state = state.copyWith(isLoading: false);
      },
      (ordersMap) {
        final allOrders = ordersMap.values.expand((list) => list).toList();

        state = state.copyWith(
          ordersByStatus: ordersMap,
          searchResults: Map.from(ordersMap),
          allOrders: allOrders,
          isLoading: false,
        );
      },
    );
  }

  void search(String key, String text, List<OrderEntity> list) {
    if (text.isEmpty) {
      resetSearch(key);
      return;
    }

    final searchText = text.toLowerCase();
    final filteredList = list.where((order) {
      final searchString = (order.date.toString() +
              order.documentNumber +
              order.status +
              order.quantityBilled.toString() +
              order.quantityOrdered.toString() +
              order.quantityReceived.toString() +
              order.vendorEntityId +
              order.vendorName)
          .toLowerCase();

      return searchString.contains(searchText);
    }).toList();

    final newSearchResults = Map<String, List<OrderEntity>>.from(state.searchResults);
    newSearchResults[key] = filteredList;

    state = state.copyWith(searchResults: newSearchResults);
  }

  void resetSearch(String? key) {
    if (key != null) {
      final newSearchResults = Map<String, List<OrderEntity>>.from(state.searchResults);
      newSearchResults[key] = state.ordersByStatus[key] ?? [];
      state = state.copyWith(searchResults: newSearchResults);
    } else {
      state = state.copyWith(searchResults: Map.from(state.ordersByStatus));
    }
  }

  void resetAllSearches() {
    state = state.copyWith(searchResults: Map.from(state.ordersByStatus));
  }

  Future<void> closeOrder(OrderEntity order) async {
    state = state.copyWith(isLoading: true);

    final updateOrderStatus = ref.read(updateOrderStatusProvider);
    final result = await updateOrderStatus(order.documentNumber, 'Closed');

    result.fold(
      (failure) {
        Alert.error(failure.message);
        state = state.copyWith(isLoading: false);
      },
      (_) {
        Alert.success('Order closed successfully');
        state = state.copyWith(isLoading: false);
        fetchOrders();
      },
    );
  }

  Future<void> openOrder(OrderEntity order) async {
    state = state.copyWith(isLoading: true);

    final updateOrderStatus = ref.read(updateOrderStatusProvider);
    final result = await updateOrderStatus(order.documentNumber, 'Open');

    result.fold(
      (failure) {
        Alert.error(failure.message);
        state = state.copyWith(isLoading: false);
      },
      (_) {
        Alert.success('Order opened successfully');
        state = state.copyWith(isLoading: false);
        fetchOrders();
      },
    );
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, OrdersState>((ref) {
  return OrdersNotifier(ref);
});
