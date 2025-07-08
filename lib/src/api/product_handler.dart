import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/product/model/product.dart';
import 'package:fake_store_api_client/src/domain/product/model/product_request.dart';
import 'package:fake_store_api_client/src/data/product/repository/product_repository_impl.dart';
import 'package:fake_store_api_client/src/domain/product/repository/product_repository.dart';

class ProductApiHandler {
  late final ProductRepository _repository;
  ProductApiHandler({required Dio dio}) {
    _repository = ProductRepositoryImpl(dio: dio);
  }

  /// Fetches the full list of products from the API.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing a `List<Product>` on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, List<Product>>> getProducts() {
    return _repository.getProducts();
  }

  /// Creates a new product on the server.
  ///
  /// Takes a [ProductRequest] object with the new product's data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the created [Product] (with its new ID) on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Product>> createProduct(ProductRequest request) {
    return _repository.createProduct(request);
  }

  /// Fetches a single product by its ID.
  ///
  /// [id] is the unique identifier of the product to fetch.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the found [Product] on success.
  /// - A [Left] containing a [Failure] on error (e.g., if not found).
  Future<Either<Failure, Product>> getProduct(int id) {
    return _repository.getProduct(id);
  }

  /// Updates an existing product on the server.
  ///
  /// [productId] is the ID of the product to update.
  /// [request] is a [ProductRequest] object with the updated data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the updated [Product] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Product>> updateProduct(int productId, ProductRequest request) {
    return _repository.updateProduct(productId, request);
  }

  /// Deletes a product from the server.
  ///
  /// The Fake Store API returns the deleted object as confirmation.
  ///
  /// [productId] is the ID of the product to delete.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the deleted [Product] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, Product>> deleteProduct(int productId) {
    return _repository.deleteProduct(productId);
  }
}