import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/login/login_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/login/login_reponse_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final RemoteDatasource remoteDatasource;

  LoginRepoImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequestModel loginUser,
  ) async {
    try {
      final response = await remoteDatasource.loginUser(loginUser);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
