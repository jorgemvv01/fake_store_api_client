import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/api.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/product/model/product.dart';
import 'package:fake_store_api_client/src/domain/product/model/product_request.dart';
import 'package:fake_store_api_client/src/domain/product/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Dio dio;
  ProductRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final response = await dio.get('/${Api.products}');
      if (response.statusCode == 200) {
        final products = List<Product>.from(response.data.map((e) => Product.fromJson(e)));
        return Right(products);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(ProductRequest request) async {
    try {
      final response = await dio.post(
        '/${Api.products}',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return Right(Product.fromJson(response.data));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }
  
  @override
  Future<Either<Failure, Product>> getProduct(int id) async{
    try {
      final response = await dio.get('/${Api.products}/$id');
      if (response.statusCode == 200) {
        final product = Product.fromJson(response.data);
        return Right(product);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }
  
  @override
  Future<Either<Failure, Product>> updateProduct(int productId, ProductRequest request) async{
    try {
      final response = await dio.put(
        '/${Api.products}/$productId',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return response.data['id'] == productId
            ? Right(Product.fromJson(response.data))
            : const Left(ServerFailure('Product ID mismatch'));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int productId) async{
    try {
      final response = await dio.delete(
        '/${Api.products}/$productId',
      );
      if (response.statusCode == 200) {
        return response.data['id'] == productId
            ? Right(Product.fromJson(response.data))
            : const Left(ServerFailure('Product ID mismatch'));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }
}