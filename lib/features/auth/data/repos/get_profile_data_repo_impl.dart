import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/get_profile_data_repo.dart';

class GetProfileDataRepoImpl extends GetProfileDataRepo {
  final RemoteDatasource remoteDatasource;

  GetProfileDataRepoImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, ProfileResponseModel>> getProfileData() async {
    try {
      final result = await remoteDatasource.getProfileData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
