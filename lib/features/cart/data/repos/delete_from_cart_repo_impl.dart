import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/delete_from_cart_response_model.dart';
import 'package:flutter_food_app/features/cart/domain/repos/delete_from_cart_repo.dart';

class DeleteFromCartRepoImpl extends DeleteFromCartRepo {
  final CartRemoteDatasource cartRemoteDatasource;

  DeleteFromCartRepoImpl({required this.cartRemoteDatasource});
  @override
  Future<Either<Failure, DeleteFromCartResponseModel>> deleteFromCart(
    int id,
  ) async {
    try {
      final response = await cartRemoteDatasource.deleteFromCart(id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
