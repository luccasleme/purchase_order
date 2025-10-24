import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';
import 'package:purchase_order/features/orders/domain/repositories/orders_repository.dart';

class GetOrdersByStatus {
  final OrdersRepository _repository;

  GetOrdersByStatus(this._repository);

  ResultFuture<Map<String, List<OrderEntity>>> call() async {
    return await _repository.getOrdersByStatus();
  }
}
