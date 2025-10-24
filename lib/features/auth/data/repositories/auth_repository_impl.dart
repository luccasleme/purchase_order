import 'package:dartz/dartz.dart';
import 'package:purchase_order/core/error/exceptions.dart';
import 'package:purchase_order/core/error/failures.dart';
import 'package:purchase_order/core/utils/typedefs.dart';
import 'package:purchase_order/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:purchase_order/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:purchase_order/features/auth/domain/entities/user_entity.dart';
import 'package:purchase_order/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  ResultFuture<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return const Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  ResultFuture<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return const Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  ResultFuture<UserEntity> getUserByEmail(String email) async {
    try {
      final user = await _remoteDataSource.getUserByEmail(email);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch user data'));
    }
  }

  @override
  ResultFuture<void> saveCredentials({
    required String email,
    required String password,
  }) async {
    try {
      await _localDataSource.saveCredentials(
        email: email,
        password: password,
      );
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(CacheFailure('Failed to save credentials'));
    }
  }

  @override
  ResultFuture<Map<String, String>> getSavedCredentials() async {
    try {
      final credentials = await _localDataSource.getSavedCredentials();
      return Right(credentials);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(CacheFailure('Failed to retrieve credentials'));
    }
  }

  @override
  ResultFuture<void> clearCredentials() async {
    try {
      await _localDataSource.clearCredentials();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(CacheFailure('Failed to clear credentials'));
    }
  }

  @override
  ResultFuture<bool> getRememberMe() async {
    try {
      final rememberMe = await _localDataSource.getRememberMe();
      return Right(rememberMe);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(CacheFailure('Failed to get remember me preference'));
    }
  }

  @override
  ResultFuture<void> setRememberMe(bool value) async {
    try {
      await _localDataSource.setRememberMe(value);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(CacheFailure('Failed to set remember me preference'));
    }
  }
}
