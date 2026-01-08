import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_model.dart';
import 'package:flutter_food_app/features/product/domain/repos/get_side_options_repo.dart';

class GetSideOptionsRepoImpl extends GetSideOptionsRepo {
  final ProductRemoteDatasource productRemoteDatasource;

  GetSideOptionsRepoImpl({required this.productRemoteDatasource});

  @override
  Future<Either<Failure, GetSideOptionsResponseModel>> getSideoptions() async {
    try {
      final response = await productRemoteDatasource.getSideoptions();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
