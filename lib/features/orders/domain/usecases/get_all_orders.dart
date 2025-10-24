import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';
import 'package:purchase_order/features/orders/domain/repositories/orders_repository.dart';

class GetAllOrders {
  final OrdersRepository _repository;

  GetAllOrders(this._repository);

  ResultFuture<List<OrderEntity>> call() async {
    return await _repository.getAllOrders();
  }
}
