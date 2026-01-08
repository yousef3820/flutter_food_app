import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_model.dart';
import 'package:flutter_food_app/features/product/domain/repos/get_toppings_repo.dart';

class GetToppingsRepoImpl extends GetToppingsRepo {
  final ProductRemoteDatasource productRemoteDatasource;

  GetToppingsRepoImpl({required this.productRemoteDatasource});
  @override
  Future<Either<Failure, GetToppingsResponseModel>> getToppings() async {
    try {
      final result = await productRemoteDatasource.getToppings();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
