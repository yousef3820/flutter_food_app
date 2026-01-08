import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_response_model.dart';

abstract class GetAllProductsRepo {
  Future<Either<Failure,ProductsResponseModel>>getProducts();
}