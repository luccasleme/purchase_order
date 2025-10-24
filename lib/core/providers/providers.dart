import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchase_order/core/network/firebase_service.dart';
import 'package:purchase_order/core/utils/secure_storage_helper.dart';
import 'package:purchase_order/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:purchase_order/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:purchase_order/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';
import 'package:purchase_order/features/auth/domain/usecases/get_user.dart';
import 'package:purchase_order/features/auth/domain/usecases/manage_credentials.dart';
import 'package:purchase_order/features/auth/domain/usecases/sign_in.dart';
import 'package:purchase_order/features/auth/domain/usecases/sign_out.dart';
import 'package:purchase_order/features/auth/domain/usecases/sign_up.dart';
import 'package:purchase_order/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:purchase_order/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:purchase_order/features/orders/domain/repositories/orders_repository.dart';
import 'package:purchase_order/features/orders/domain/usecases/get_all_orders.dart';
import 'package:purchase_order/features/orders/domain/usecases/get_orders_by_status.dart';
import 'package:purchase_order/features/orders/domain/usecases/update_order_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core Services
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

final secureStorageHelperProvider = Provider<SecureStorageHelper>((ref) {
  return SecureStorageHelper();
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

// Auth Data Sources
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(firebaseServiceProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(
    ref.watch(secureStorageHelperProvider),
    ref.watch(sharedPreferencesProvider),
  );
});

// Auth Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(authLocalDataSourceProvider),
  );
});

// Auth Use Cases
final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.watch(authRepositoryProvider));
});

final signUpProvider = Provider<SignUp>((ref) {
  return SignUp(ref.watch(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});

final getUserProvider = Provider<GetUser>((ref) {
  return GetUser(ref.watch(authRepositoryProvider));
});

final saveCredentialsProvider = Provider<SaveCredentials>((ref) {
  return SaveCredentials(ref.watch(authRepositoryProvider));
});

final getSavedCredentialsProvider = Provider<GetSavedCredentials>((ref) {
  return GetSavedCredentials(ref.watch(authRepositoryProvider));
});

final clearCredentialsProvider = Provider<ClearCredentials>((ref) {
  return ClearCredentials(ref.watch(authRepositoryProvider));
});

// Orders Data Source
final ordersRemoteDataSourceProvider = Provider<OrdersRemoteDataSource>((ref) {
  return OrdersRemoteDataSourceImpl(ref.watch(firebaseServiceProvider));
});

// Orders Repository
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepositoryImpl(ref.watch(ordersRemoteDataSourceProvider));
});

// Orders Use Cases
final getAllOrdersProvider = Provider<GetAllOrders>((ref) {
  return GetAllOrders(ref.watch(ordersRepositoryProvider));
});

final getOrdersByStatusProvider = Provider<GetOrdersByStatus>((ref) {
  return GetOrdersByStatus(ref.watch(ordersRepositoryProvider));
});

final updateOrderStatusProvider = Provider<UpdateOrderStatus>((ref) {
  return UpdateOrderStatus(ref.watch(ordersRepositoryProvider));
});
