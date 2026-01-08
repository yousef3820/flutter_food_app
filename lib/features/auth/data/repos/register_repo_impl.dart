import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/register/register_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/register/register_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/register_repo.dart';

class RegisterRepoImpl extends RegisterRepo {
  final RemoteDatasource dataSource;

  RegisterRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, RegisterResponseModel>> register(
    RegisterRequestModel registerUser,
  ) async {
    try {
      final result = await dataSource.registerUser(registerUser);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
