import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/delete_from_cart_response_model.dart';
import 'package:flutter_food_app/features/cart/domain/repos/delete_from_cart_repo.dart';

class DeleteFromCartUsecase {
  final DeleteFromCartRepo deleteFromCartRepo;

  DeleteFromCartUsecase({required this.deleteFromCartRepo});

  Future<Either<Failure, DeleteFromCartResponseModel>> call(int id) {
    return deleteFromCartRepo.deleteFromCart(id);
  }
}
