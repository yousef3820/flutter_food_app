import 'package:dartz/dartz.dart';
import 'package:flutter_food_app/core/errors/failure.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/get_user_favorites_model.dart';
import 'package:flutter_food_app/features/favorites/domain/repo/get_user_favorites_repo.dart';

class GetUserFavoritesRepoImpl extends GetUserFavoritesRepo {
  final FavoritesRemoteDatasource favoritesRemoteDatasource;

  GetUserFavoritesRepoImpl({required this.favoritesRemoteDatasource});
  @override
  Future<Either<Failure, GetUserFavoritesModel>> getUserFavorites() async {
    try {
      final response = await favoritesRemoteDatasource.gatUserFavorites();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
