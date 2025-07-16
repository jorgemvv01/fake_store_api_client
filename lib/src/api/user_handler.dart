import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/data/user/repository/user_repository_impl.dart';
import 'package:fake_store_api_client/src/domain/user/model/user.dart';
import 'package:fake_store_api_client/src/domain/user/model/user_request.dart';
import 'package:fake_store_api_client/src/domain/user/repository/user_repository.dart';


class UserApiHandler {
  late final UserRepository _repository;
  UserApiHandler({required Dio dio}) {
    _repository = UserRepositoryImpl(dio: dio);
  }

  /// Fetches the full list of users from the API.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing a `List<User>` on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, List<User>>> getUsers() {
    return _repository.getUsers();
  }

  /// Creates a new user on the server.
  ///
  /// Takes a [UserRequest] object with the new user's data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] contains an `int`, which represents the ID of the created user.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, int>> createUser(UserRequest request) {
    return _repository.createUser(request);
  }

  /// Fetches a single user by their ID.
  ///
  /// [id] is the unique identifier of the user to fetch.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the found [User] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, User>> getUser(int id) {
    return _repository.getUser(id);
  }

  /// Updates an existing user on the server.
  ///
  /// [userId] is the ID of the user to update.
  /// [request] is a [UserRequest] object with the updated data.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the updated [User] on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, User>> updateUser(int userId, UserRequest request) {
    return _repository.updateUser(userId, request);
  }

  /// Deletes a user from the server.
  ///
  /// [userId] is the ID of the user to delete.
  ///
  /// Returns a [Future] that completes with an [Either]:
  /// - A [Right] containing the deleted [User] as confirmation on success.
  /// - A [Left] containing a [Failure] on error.
  Future<Either<Failure, User>> deleteUser(int userId) {
    return _repository.deleteUser(userId);
  }
}