import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/orders/domain/repositories/orders_repository.dart';

class UpdateOrderStatus {
  final OrdersRepository _repository;

  UpdateOrderStatus(this._repository);

  ResultVoid call(String documentNumber, String newStatus) async {
    return await _repository.updateOrderStatus(documentNumber, newStatus);
  }
}
