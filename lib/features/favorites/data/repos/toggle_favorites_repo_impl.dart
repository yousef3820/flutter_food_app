import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/toggle_favorites_reponse_model.dart';
import 'package:flutter_food_app/features/favorites/domain/repo/toggle_favorites_repo.dart';

class ToggleFavoritesRepoImpl extends ToggleFavoritesRepo {
  final FavoritesRemoteDatasource favoritesRemoteDatasource;

  ToggleFavoritesRepoImpl({required this.favoritesRemoteDatasource});
  @override
  Future<Either<Failure, ToggleFavoritesReponseModel>> toggleFavorites(
    ToggleFavoritesRequestModel favorites,
  ) async {
    try {
      final response = await favoritesRemoteDatasource.toggleFavorites(
        favorites,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
