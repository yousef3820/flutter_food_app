import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_model.dart';

abstract class GetSideOptionsRepo {
  Future<Either<Failure,GetSideOptionsResponseModel>>getSideoptions();
}