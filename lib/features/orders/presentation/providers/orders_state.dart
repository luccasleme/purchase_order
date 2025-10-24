import 'package:equatable/equatable.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';

class OrdersState extends Equatable {
  final List<OrderEntity> allOrders;
  final Map<String, List<OrderEntity>> ordersByStatus;
  final Map<String, List<OrderEntity>> searchResults;
  final bool isLoading;

  const OrdersState({
    this.allOrders = const [],
    this.ordersByStatus = const {},
    this.searchResults = const {},
    this.isLoading = false,
  });

  OrdersState copyWith({
    List<OrderEntity>? allOrders,
    Map<String, List<OrderEntity>>? ordersByStatus,
    Map<String, List<OrderEntity>>? searchResults,
    bool? isLoading,
  }) {
    return OrdersState(
      allOrders: allOrders ?? this.allOrders,
      ordersByStatus: ordersByStatus ?? this.ordersByStatus,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        allOrders,
        ordersByStatus,
        searchResults,
        isLoading,
      ];
}
