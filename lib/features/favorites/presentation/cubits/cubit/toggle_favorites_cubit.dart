import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/get_user_favorites_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/toggle_favorites_reponse_model.dart';
import 'package:flutter_food_app/features/favorites/domain/usecases/get_user_favorites_usecase.dart';
import 'package:flutter_food_app/features/favorites/domain/usecases/toggle_favorites_usecase.dart';
import 'package:meta/meta.dart';

part 'toggle_favorites_state.dart';

class ToggleFavoritesCubit extends Cubit<ToggleFavoritesState> {
  final ToggleFavoritesUsecase toggleFavoritesUsecase =
      locator<ToggleFavoritesUsecase>();
  final GetUserFavoritesUsecase getUserFavoritesUsecase =
      locator<GetUserFavoritesUsecase>();

  /// 🔥 THIS IS THE KEY
  Set<int> favoriteProductIds = {};

  ToggleFavoritesCubit() : super(ToggleFavoritesInitial());

  Future<void> getUserFavorites() async {
    emit(GetFavoritesLoading());

    final response = await getUserFavoritesUsecase.call();
    response.fold(
      (failure) {
        emit(ToggleFavoritesFailure(errorMessage: failure.errorMessage));
      },
      (success) {
        /// 🔥 Extract IDs here
        favoriteProductIds = success.data.map((fav) => fav.id).toSet();
        print("////////////////////////////////////////////");
        print(favoriteProductIds);
        print("////////////////////////////////////////////");

        emit(GetFavoritesSuccess(favorites: success));
      },
    );
  }

  Future<void> toggleFavorites(
    ToggleFavoritesRequestModel toggleFavorites,
  ) async {
    emit(ToggleFavoritesLoading());

    final response = await toggleFavoritesUsecase.call(toggleFavorites);
    response.fold(
      (failure) =>
          emit(ToggleFavoritesFailure(errorMessage: failure.errorMessage)),
      (success) {
        final productId = toggleFavorites.productId;

        if (favoriteProductIds.contains(productId)) {
          favoriteProductIds.remove(productId);
        } else {
          favoriteProductIds.add(productId);
        }

        emit(ToggleFavoritesSuccess(favorites: success));

        getUserFavorites();
      },
    );
  }

  /// 🔥 Helper method
  bool isFavorite(int productId) {
    return favoriteProductIds.contains(productId);
  }
}
