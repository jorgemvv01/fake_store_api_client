import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/api/auth_handler.dart';
import 'package:fake_store_api_client/src/api/cart_handler.dart';
import 'package:fake_store_api_client/src/api/product_handler.dart';
import 'package:fake_store_api_client/src/api/user_handler.dart';

class FakeStoreApiClient {
  late final Dio _dio;

  /// Provides access to all product-related API operations.
  late final ProductApiHandler products;

  /// Provides access to all cart-related API operations.
  late final CartApiHandler carts;

  /// Provides access to all user-related API operations.
  late final UserApiHandler users;

  /// Provides access to all auth-related API operations.
  late final AuthApiHandler auth;

  /// The main entry point for interacting with the Fake Store API.
  ///
  /// This client provides access to different API resources like
  /// products, carts, and users through its properties.
  FakeStoreApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com',
        connectTimeout: const Duration(seconds: 5),
      ),
    );
    products = ProductApiHandler(dio: _dio);
    carts = CartApiHandler(dio: _dio);
    users = UserApiHandler(dio: _dio);
    auth = AuthApiHandler(dio: _dio);
  }
}