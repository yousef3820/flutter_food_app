import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/profile/update_profile_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/update_profile/update_profile_response_model.dart';

abstract class UpdateProfileDateRepo {
  Future<Either<Failure, UpdateProfileResponseModel>> updateProfile(
    UpdateProfileRequestModel updateProfile,
  );
}
