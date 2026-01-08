import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_response_model.dart';
import 'package:flutter_food_app/features/home/domain/repos/get_all_products_repo.dart';

class GetAllProductsUsecase {
  final GetAllProductsRepo getAllProductsRepo;

  GetAllProductsUsecase({required this.getAllProductsRepo});

  Future<Either<Failure, ProductsResponseModel>> call() {
    return getAllProductsRepo.getProducts();
  }
}
