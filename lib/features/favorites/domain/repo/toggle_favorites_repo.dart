import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/toggle_favorites_reponse_model.dart';

abstract class ToggleFavoritesRepo {
  Future<Either<Failure,ToggleFavoritesReponseModel>>toggleFavorites(ToggleFavoritesRequestModel favorites);
}