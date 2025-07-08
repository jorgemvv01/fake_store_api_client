import 'package:dartz/dartz.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/cart/model/cart.dart';
import 'package:fake_store_api_client/src/domain/cart/model/cart_request.dart';

abstract class CartRepository {
  Future<Either<Failure, List<Cart>>> getCarts();
  Future<Either<Failure, Cart>> createCart(CartRequest request);
  Future<Either<Failure, Cart>> getCart(int id);
  Future<Either<Failure, Cart>> updateCart(int cartId, CartRequest request);
  Future<Either<Failure, Cart>> deleteCart(int cartId);
}