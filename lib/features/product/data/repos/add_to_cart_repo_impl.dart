import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_request_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/cart/add_to_cart_response_model.dart';
import 'package:flutter_food_app/features/product/domain/repos/add_to_cart_repo.dart';

class AddToCartRepoImpl extends AddToCartRepo {
  final ProductRemoteDatasource productRemoteDatasource;

  AddToCartRepoImpl({required this.productRemoteDatasource});
  @override
  Future<Either<Failure, AddToCartResponseModel>> addTocart(
    AddToCartRequestModel addOrder,
  ) async {
    try {
      final result = await productRemoteDatasource.addTocart(addOrder);
      return right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
