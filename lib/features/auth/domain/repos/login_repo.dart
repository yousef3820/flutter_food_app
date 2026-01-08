import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/login/login_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/login/login_reponse_model.dart';

abstract class LoginRepo {
  Future<Either<Failure,LoginResponseModel>>login(LoginRequestModel loginUser);
}