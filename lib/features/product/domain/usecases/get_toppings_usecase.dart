import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_model.dart';
import 'package:flutter_food_app/features/product/domain/repos/get_toppings_repo.dart';

class GetToppingsUsecase {
  final GetToppingsRepo getToppingsRepo;

  GetToppingsUsecase({required this.getToppingsRepo});

  Future<Either<Failure,GetToppingsResponseModel>>call()
  {
    return getToppingsRepo.getToppings();
  }
}