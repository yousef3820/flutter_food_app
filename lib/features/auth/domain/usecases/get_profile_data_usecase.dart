import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/get_profile_data_repo.dart';

class GetProfileDataUsecase {
  final GetProfileDataRepo getProfileDataRepo;

  GetProfileDataUsecase({required this.getProfileDataRepo});

  Future<Either<Failure, ProfileResponseModel>> call() {
    return getProfileDataRepo.getProfileData();
  }
}
