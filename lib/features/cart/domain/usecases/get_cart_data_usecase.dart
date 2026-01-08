import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_response.dart';
import 'package:flutter_food_app/features/cart/domain/repos/get_cart_data_repo.dart';

class GetCartDataUsecase {
  final GetCartDataRepo getCartDataRepo;

  GetCartDataUsecase({required this.getCartDataRepo});

  Future<Either<Failure,GetCartResponse>>call()
  {
    return getCartDataRepo.getCartData();
  }
}