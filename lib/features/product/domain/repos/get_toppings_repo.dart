import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_model.dart';

abstract class GetToppingsRepo {
  Future<Either<Failure,GetToppingsResponseModel>>getToppings();
}