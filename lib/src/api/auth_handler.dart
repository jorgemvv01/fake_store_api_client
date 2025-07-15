import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/fake_store_api_client.dart';
import 'package:fake_store_api_client/src/data/auth/repository/auth_repository_impl.dart';
import 'package:fake_store_api_client/src/domain/auth/repository/auth_repository.dart';


class AuthApiHandler {
  late final AuthRepository _repository;
  AuthApiHandler({required Dio dio}) {
    _repository = AuthRepositoryImpl(dio: dio);
  }

  /// Login from the API.
  /// 
  /// Takes a [LoginRequest] object with the user's data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing a `String` as Token on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, String>> login(LoginRequest request) {
    return _repository.login(request);
  }
}