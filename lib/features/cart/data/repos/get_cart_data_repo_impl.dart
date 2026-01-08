import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_response.dart';
import 'package:flutter_food_app/features/cart/domain/repos/get_cart_data_repo.dart';

class GetCartDataRepoImpl extends GetCartDataRepo {
  final CartRemoteDatasource cartRemoteDatasource;

  GetCartDataRepoImpl({required this.cartRemoteDatasource});
  @override
  Future<Either<Failure, GetCartResponse>> getCartData() async {
    try {
      final response = await cartRemoteDatasource.getCartData();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
