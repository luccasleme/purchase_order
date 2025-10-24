import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final DateTime date;
  final String documentNumber;
  final String status;
  final int quantityOrdered;
  final String vendorEntityId;
  final String vendorName;
  final int quantityBilled;
  final int quantityReceived;

  const OrderEntity({
    required this.date,
    required this.documentNumber,
    required this.status,
    required this.quantityOrdered,
    required this.vendorEntityId,
    required this.vendorName,
    required this.quantityBilled,
    required this.quantityReceived,
  });

  @override
  List<Object?> get props => [
        date,
        documentNumber,
        status,
        quantityOrdered,
        vendorEntityId,
        vendorName,
        quantityBilled,
        quantityReceived,
      ];
}
