import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/api.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/cart/model/cart.dart';
import 'package:fake_store_api_client/src/domain/cart/model/cart_request.dart';
import 'package:fake_store_api_client/src/domain/cart/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final Dio dio;
  CartRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<Cart>>> getCarts() async {
    try {
      final response = await dio.get('/${Api.carts}');
      if (response.statusCode == 200) {
        final carts = List<Cart>.from(response.data.map((e) => Cart.fromJson(e)));
        return Right(carts);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Cart>> createCart(CartRequest request) async {
    try {
      final response = await dio.post(
        '/${Api.carts}',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return Right(Cart.fromJson(response.data));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart(int id) async {
    try {
      final response = await dio.get('/${Api.carts}/$id');
      if (response.statusCode == 200) {
        final cart = Cart.fromJson(response.data);
        return Right(cart);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Cart>> updateCart(int cartId, CartRequest request) async {
    try {
      final response = await dio.put(
        '/${Api.carts}/$cartId',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return response.data['id'] == cartId
            ? Right(Cart.fromUpdateJson(response.data))
            : const Left(ServerFailure('Cart ID mismatch'));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Cart>> deleteCart(int cartId) async {
    try {
      final response = await dio.delete('/${Api.carts}/$cartId');
      if (response.statusCode == 200) {
        return response.data['id'] == cartId
            ? Right(Cart.fromJson(response.data))
            : const Left(ServerFailure('Cart ID mismatch'));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }
}