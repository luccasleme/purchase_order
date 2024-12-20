class OrderModel {
  final DateTime date;
  final String documentNumber;
  final String status;
  final int quantityOrdered;
  final String vendorEntityId;
  final String vendorName;
  final int quantityBilled;
  final int quantityReceived;

  OrderModel({
    required this.date,
    required this.documentNumber,
    required this.status,
    required this.quantityOrdered,
    required this.vendorEntityId,
    required this.vendorName,
    required this.quantityBilled,
    required this.quantityReceived,
  });

  factory OrderModel.mock() {
    return OrderModel(
      date: DateTime.now(),
      documentNumber: 'documentNumber',
      status: 'status',
      quantityOrdered: 0,
      vendorEntityId: 'vendorEntityId',
      vendorName: 'vendorName',
      quantityBilled: 0,
      quantityReceived: 0,
    );
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final OrderModel orderFromMap = OrderModel(
      date: map['date'].toDate() ?? DateTime.now(),
      documentNumber: map['documentNumber'] ?? '',
      status: map['status'] ?? '',
      quantityOrdered: map['quantityOrdered'] ?? 0,
      vendorEntityId: map['vendorEntityId'] ?? '',
      vendorName: map['vendorName'] ?? '',
      quantityBilled: map['quantityBilled'] ?? 0,
      quantityReceived: map['quantityReceived'] ?? 0,
    );
    return orderFromMap;
  }

  static Map<String, dynamic> toMap(OrderModel order) {
    Map<String, dynamic> map = {
      'date': order.date,
      'documentNumber': order.documentNumber,
      'status': order.status,
      'quantityOrdered': order.quantityOrdered,
      'vendorEntityId': order.vendorEntityId,
      'vendorName': order.vendorName,
      'quantityBilled': order.quantityBilled,
      'quantityReceived': order.quantityReceived,
    };
    return map;
  }
}
