import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/api.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/user/model/user.dart';
import 'package:fake_store_api_client/src/domain/user/model/user_request.dart';
import 'package:fake_store_api_client/src/domain/user/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;
  UserRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final response = await dio.get('/${Api.users}');
      if (response.statusCode == 200) {
        final users = List<User>.from(response.data.map((e) => User.fromJson(e)));
        return Right(users);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> createUser(UserRequest request) async {
    try {
      final response = await dio.post(
        '/${Api.users}',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return Right(response.data["id"]);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(int id) async {
    try {
      final response = await dio.get('/${Api.users}/$id');
      if (response.statusCode == 200) {
        return Right(User.fromJson(response.data));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(int userId, UserRequest request) async {
    try {
      final response = await dio.put(
        '/${Api.users}/$userId',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return Right(User.fromJson(response.data));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> deleteUser(int userId) async {
    try {
      final response = await dio.delete('/${Api.users}/$userId');
      if (response.statusCode == 200) {
        return Right(User.fromJson(response.data));
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }
}