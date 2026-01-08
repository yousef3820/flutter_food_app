part of 'toggle_favorites_cubit.dart';

@immutable
sealed class ToggleFavoritesState {}

final class ToggleFavoritesInitial extends ToggleFavoritesState {}

final class ToggleFavoritesLoading extends ToggleFavoritesState {}

final class ToggleFavoritesSuccess extends ToggleFavoritesState {
  final ToggleFavoritesReponseModel favorites;

  ToggleFavoritesSuccess({required this.favorites});
}

final class GetFavoritesLoading extends ToggleFavoritesState {}

final class GetFavoritesSuccess extends ToggleFavoritesState {
  final GetUserFavoritesModel favorites;

  GetFavoritesSuccess({required this.favorites});
}

final class ToggleFavoritesFailure extends ToggleFavoritesState {
  final String errorMessage;

  ToggleFavoritesFailure({required this.errorMessage});
}
