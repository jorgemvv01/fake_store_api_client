import 'package:dartz/dartz.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/product/model/product.dart';
import 'package:fake_store_api_client/src/domain/product/model/product_request.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> createProduct(ProductRequest request);
  Future<Either<Failure, Product>> getProduct(int id);
  Future<Either<Failure, Product>> updateProduct(int productId, ProductRequest request);
  Future<Either<Failure, Product>> deleteProduct(int productId);
}