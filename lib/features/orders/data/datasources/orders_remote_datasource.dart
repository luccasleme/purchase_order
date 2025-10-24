import 'package:firebase_core/firebase_core.dart';
import 'package:purchase_order/core/constants/app_constants.dart';
import 'package:purchase_order/core/error/exceptions.dart';
import 'package:purchase_order/core/network/firebase_service.dart';
import 'package:purchase_order/features/orders/data/models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getAllOrders();
  Future<void> updateOrderStatus(String documentNumber, String newStatus);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final FirebaseService _firebaseService;

  OrdersRemoteDataSourceImpl(this._firebaseService);

  @override
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final doc = await _firebaseService.firestore
          .collection(AppConstants.ordersCollection)
          .doc(AppConstants.allOrdersDocument)
          .get();

      if (!doc.exists || doc.data() == null) {
        throw ServerException('No orders found');
      }

      final data = doc.data()!;
      final ordersData = data['allOrders'] as List<dynamic>?;

      if (ordersData == null) {
        throw ServerException('Invalid orders data format');
      }

      return ordersData
          .map((orderMap) => OrderModel.fromMap(orderMap as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch orders');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('An unexpected error occurred');
    }
  }

  @override
  Future<void> updateOrderStatus(String documentNumber, String newStatus) async {
    try {
      final doc = await _firebaseService.firestore
          .collection(AppConstants.ordersCollection)
          .doc(AppConstants.allOrdersDocument)
          .get();

      if (!doc.exists || doc.data() == null) {
        throw ServerException('No orders found');
      }

      final data = doc.data()!;
      final ordersData = data['allOrders'] as List<dynamic>?;

      if (ordersData == null) {
        throw ServerException('Invalid orders data format');
      }

      final updatedOrders = ordersData.map((orderMap) {
        final map = orderMap as Map<String, dynamic>;
        if (map['documentNumber'] == documentNumber) {
          return {...map, 'status': newStatus};
        }
        return map;
      }).toList();

      await _firebaseService.firestore
          .collection(AppConstants.ordersCollection)
          .doc(AppConstants.allOrdersDocument)
          .update({'allOrders': updatedOrders});
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to update order status');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('An unexpected error occurred');
    }
  }
}
