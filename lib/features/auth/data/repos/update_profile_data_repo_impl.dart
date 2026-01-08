import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/profile/update_profile_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/update_profile/update_profile_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/update_profile_date_repo.dart';

class UpdateProfileDataRepoImpl extends UpdateProfileDateRepo {
  final RemoteDatasource remoteDatasource;

  UpdateProfileDataRepoImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, UpdateProfileResponseModel>> updateProfile(
    UpdateProfileRequestModel updateProfile,
  ) async {
    try {
      final response = await remoteDatasource.updateProfileData(updateProfile);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
