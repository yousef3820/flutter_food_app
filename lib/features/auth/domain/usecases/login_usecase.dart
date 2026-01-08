import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/login/login_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/login/login_reponse_model.dart';
import 'package:flutter_food_app/features/auth/domain/repos/login_repo.dart';

class LoginUsecase {
  final LoginRepo loginRepo;

  LoginUsecase({required this.loginRepo});

  Future<Either<Failure, LoginResponseModel>> call(
    LoginRequestModel loginUser,
  ) {
    return loginRepo.login(loginUser);
  }
}
