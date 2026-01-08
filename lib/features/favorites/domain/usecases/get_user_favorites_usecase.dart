import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/get_user_favorites_model.dart';
import 'package:flutter_food_app/features/favorites/domain/repo/get_user_favorites_repo.dart';

class GetUserFavoritesUsecase {
  final GetUserFavoritesRepo getUserFavoritesRepo;

  GetUserFavoritesUsecase({required this.getUserFavoritesRepo});

  Future<Either<Failure, GetUserFavoritesModel>> call() {
    return getUserFavoritesRepo.getUserFavorites();
  }
}
