import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/delete_from_cart_response_model.dart';

abstract class DeleteFromCartRepo {
  Future<Either<Failure,DeleteFromCartResponseModel>>deleteFromCart(int id);
}