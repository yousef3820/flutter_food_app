import 'package:flutter_food_app/core/network/api_consumer.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/get_user_favorites_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/toggle_favorites_reponse_model.dart';

class FavoritesRemoteDatasource {
  final ApiConsumer api;

  FavoritesRemoteDatasource({required this.api});

  Future<ToggleFavoritesReponseModel> toggleFavorites(
    ToggleFavoritesRequestModel favorites,
  ) async {
    final response = await api.post(
      "${ApiEndpoints.toggleFavorite}",
      data: favorites.toJson(),
    );
    return ToggleFavoritesReponseModel.fromJson(response);
  }

  Future<GetUserFavoritesModel> gatUserFavorites() async {
    final response = await api.get("${ApiEndpoints.getUserFavorites}");
    return GetUserFavoritesModel.fromJson(response);
  }
}
