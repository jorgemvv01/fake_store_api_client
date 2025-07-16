import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_api_client/src/core/api.dart';
import 'package:fake_store_api_client/src/core/failure.dart';
import 'package:fake_store_api_client/src/domain/auth/model/login_request.dart';
import 'package:fake_store_api_client/src/domain/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  AuthRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, String>> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '/${Api.authLogin}',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return Right(response.data["token"]);
      }
      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } on DioException catch(e){
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          return const Left(ServerFailure('Username or password is incorrect'));
        }
        return Left(ServerFailure('Server error: ${e.response?.statusCode}'));
      }
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure('An error has occurred: $e'));
    }
  }
}