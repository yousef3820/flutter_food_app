import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/profile/update_profile_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/update_profile/update_profile_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/update_profile_date_repo.dart';

class UpdateProfileDataUsecase {
  final UpdateProfileDateRepo updateProfileDataRepo;

  UpdateProfileDataUsecase({required this.updateProfileDataRepo});

  Future<Either<Failure, UpdateProfileResponseModel>> call(
    UpdateProfileRequestModel updateProfile,
  ) {
    return updateProfileDataRepo.updateProfile(updateProfile);
  }
}
