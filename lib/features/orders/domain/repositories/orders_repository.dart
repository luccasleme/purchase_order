import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';

abstract class OrdersRepository {
  ResultFuture<List<OrderEntity>> getAllOrders();

  ResultFuture<Map<String, List<OrderEntity>>> getOrdersByStatus();

  ResultVoid updateOrderStatus(String documentNumber, String newStatus);
}
