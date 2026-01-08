import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/register/register_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/register/register_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/register_repo.dart';
class RegisterUsecase {
  final RegisterRepo registerUsecase;

  RegisterUsecase({required this.registerUsecase});

  Future<Either<Failure, RegisterResponseModel>> call(
    RegisterRequestModel registerUser,
  ) {
    return registerUsecase.register(registerUser);
  }
}
