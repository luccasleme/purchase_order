import 'package:dartz/dartz.dart';
import 'package:purchase_order/core/error/exceptions.dart';
import 'package:purchase_order/core/error/failures.dart';
import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:purchase_order/features/orders/domain/entities/order_entity.dart';
import 'package:purchase_order/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<List<OrderEntity>> getAllOrders() async {
    try {
      final orders = await _remoteDataSource.getAllOrders();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch orders'));
    }
  }

  @override
  ResultFuture<Map<String, List<OrderEntity>>> getOrdersByStatus() async {
    try {
      final orders = await _remoteDataSource.getAllOrders();
      final groupedOrders = _groupOrdersByStatus(orders);
      return Right(groupedOrders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch orders'));
    }
  }

  @override
  ResultVoid updateOrderStatus(String documentNumber, String newStatus) async {
    try {
      await _remoteDataSource.updateOrderStatus(documentNumber, newStatus);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to update order status'));
    }
  }

  Map<String, List<OrderEntity>> _groupOrdersByStatus(
      List<OrderEntity> orders) {
    final Map<String, List<OrderEntity>> groupedOrders = {};

    for (var order in orders) {
      groupedOrders.putIfAbsent(order.status, () => []);
      groupedOrders[order.status]!.add(order);
    }

    return groupedOrders;
  }
}
