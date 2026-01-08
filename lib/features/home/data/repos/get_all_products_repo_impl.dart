import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/home/data/datasources/products_remote_data_source.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_response_model.dart';
import 'package:flutter_food_app/features/home/domain/repos/get_all_products_repo.dart';

class GetAllProductsRepoImpl extends GetAllProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;

  GetAllProductsRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, ProductsResponseModel>> getProducts() async {
    try {
      final response = await remoteDataSource.getAllProducts();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
