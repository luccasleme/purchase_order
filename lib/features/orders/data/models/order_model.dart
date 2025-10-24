import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.date,
    required super.documentNumber,
    required super.status,
    required super.quantityOrdered,
    required super.vendorEntityId,
    required super.vendorName,
    required super.quantityBilled,
    required super.quantityReceived,
  });

  factory OrderModel.fromMap(DataMap map) {
    return OrderModel(
      date: map['date']?.toDate() ?? DateTime.now(),
      documentNumber: map['documentNumber'] as String? ?? '',
      status: map['status'] as String? ?? '',
      quantityOrdered: map['quantityOrdered'] as int? ?? 0,
      vendorEntityId: map['vendorEntityId'] as String? ?? '',
      vendorName: map['vendorName'] as String? ?? '',
      quantityBilled: map['quantityBilled'] as int? ?? 0,
      quantityReceived: map['quantityReceived'] as int? ?? 0,
    );
  }

  DataMap toMap() {
    return {
      'date': date,
      'documentNumber': documentNumber,
      'status': status,
      'quantityOrdered': quantityOrdered,
      'vendorEntityId': vendorEntityId,
      'vendorName': vendorName,
      'quantityBilled': quantityBilled,
      'quantityReceived': quantityReceived,
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      date: entity.date,
      documentNumber: entity.documentNumber,
      status: entity.status,
      quantityOrdered: entity.quantityOrdered,
      vendorEntityId: entity.vendorEntityId,
      vendorName: entity.vendorName,
      quantityBilled: entity.quantityBilled,
      quantityReceived: entity.quantityReceived,
    );
  }

  OrderModel copyWith({
    DateTime? date,
    String? documentNumber,
    String? status,
    int? quantityOrdered,
    String? vendorEntityId,
    String? vendorName,
    int? quantityBilled,
    int? quantityReceived,
  }) {
    return OrderModel(
      date: date ?? this.date,
      documentNumber: documentNumber ?? this.documentNumber,
      status: status ?? this.status,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
      vendorEntityId: vendorEntityId ?? this.vendorEntityId,
      vendorName: vendorName ?? this.vendorName,
      quantityBilled: quantityBilled ?? this.quantityBilled,
      quantityReceived: quantityReceived ?? this.quantityReceived,
    );
  }
}
