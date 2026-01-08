import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/toggle_favorites_reponse_model.dart';
import 'package:flutter_food_app/features/favorites/domain/repo/toggle_favorites_repo.dart';

class ToggleFavoritesUsecase {
  final ToggleFavoritesRepo toggleFavoritesRepo;

  ToggleFavoritesUsecase({required this.toggleFavoritesRepo});

  Future<Either<Failure,ToggleFavoritesReponseModel>>call(ToggleFavoritesRequestModel favorites){
    return toggleFavoritesRepo.toggleFavorites(favorites);
  }
}