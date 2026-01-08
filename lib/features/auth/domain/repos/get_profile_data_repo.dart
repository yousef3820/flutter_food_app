import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_response_model.dart';

abstract class GetProfileDataRepo {
  Future<Either<Failure,ProfileResponseModel>>getProfileData();
}