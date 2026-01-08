import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_model.dart';
import 'package:flutter_food_app/features/product/domain/repos/get_side_options_repo.dart';

class GetSideOptionsUsecase {
  final GetSideOptionsRepo getSideOptionsRepo;

  GetSideOptionsUsecase({required this.getSideOptionsRepo});

  Future<Either<Failure,GetSideOptionsResponseModel>>call()
  {
    return getSideOptionsRepo.getSideoptions();
  }
}