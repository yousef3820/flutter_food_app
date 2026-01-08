import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/get_user_favorites_model.dart';

abstract class GetUserFavoritesRepo {
  Future<Either<Failure,GetUserFavoritesModel>>getUserFavorites();
}