import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/register/register_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/register/register_response_model.dart';

abstract class RegisterRepo {
  Future<Either<Failure, RegisterResponseModel>> register(
    RegisterRequestModel registerUser,
  );
}
