import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_response.dart';

abstract class GetCartDataRepo {
  Future<Either<Failure,GetCartResponse>>getCartData();
}