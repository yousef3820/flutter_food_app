import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/logout/logout_response_model.dart';

abstract class LogoutRepo {
  Future<Either<Failure,LogoutResponseModel>>logout();
}