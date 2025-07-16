import 'package:dartz/dartz.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/user/model/user.dart';
import 'package:fake_store_api_client/src/domain/user/model/user_request.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, int>> createUser(UserRequest request);
  Future<Either<Failure, User>> getUser(int id);
  Future<Either<Failure, User>> updateUser(int userId, UserRequest request);
  Future<Either<Failure, User>> deleteUser(int userId);
}