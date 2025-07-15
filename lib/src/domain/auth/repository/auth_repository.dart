import 'package:dartz/dartz.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/auth/model/login_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(LoginRequest request);
}