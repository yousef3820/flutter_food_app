import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/logout/logout_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/logout_repo.dart';

class LogoutRepoImpl extends LogoutRepo {
  final RemoteDatasource remoteDatasource;

  LogoutRepoImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, LogoutResponseModel>> logout() async {
    try {
      final response = await remoteDatasource.logout();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
