import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/data/cart/repository/cart_repository_impl.dart';
import 'package:fake_store_api_client/src/domain/cart/model/cart.dart';
import 'package:fake_store_api_client/src/domain/cart/model/cart_request.dart';
import 'package:fake_store_api_client/src/domain/cart/repository/cart_repository.dart';


class CartApiHandler {
  late final CartRepository _repository;
  CartApiHandler({required Dio dio}) {
    _repository = CartRepositoryImpl(dio: dio);
  }

  /// Fetches the full list of carts from the API.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing a `List<Cart>` on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, List<Cart>>> getCarts() {
    return _repository.getCarts();
  }

  /// Creates a new cart on the server.
  ///
  /// Takes a [CartRequest] object with the new cart's data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the created [Cart] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Cart>> createCart(CartRequest request) {
    return _repository.createCart(request);
  }

  /// Fetches a single cart by its ID.
  ///
  /// [id] is the unique identifier of the cart to fetch.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the found [Cart] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Cart>> getCart(int id) {
    return _repository.getCart(id);
  }

  /// Updates an existing cart on the server.
  ///
  /// [cartId] is the ID of the cart to update.
  /// [request] is a [CartRequest] object with the updated data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the updated [Cart] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Cart>> updateCart(int cartId, CartRequest request) {
    return _repository.updateCart(cartId, request);
  }

  /// Deletes a cart from the server.
  ///
  /// [cartId] is the ID of the cart to delete.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the deleted [Cart] as confirmation on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Cart>> deleteCart(int cartId) {
    return _repository.deleteCart(cartId);
  }
}