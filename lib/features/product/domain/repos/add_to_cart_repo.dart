import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_request_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/cart/add_to_cart_response_model.dart';

abstract class AddToCartRepo {
  Future<Either<Failure,AddToCartResponseModel>>addTocart(AddToCartRequestModel addOrder);
}