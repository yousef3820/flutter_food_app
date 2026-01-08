import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/logout/logout_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/logout_repo.dart';

class LogoutUsecase {
  final LogoutRepo logoutRepo;

  LogoutUsecase({required this.logoutRepo});

  Future<Either<Failure,LogoutResponseModel>>call(){
    return logoutRepo.logout();
  }
}