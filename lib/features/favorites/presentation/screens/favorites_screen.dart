import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/favorites_data_model.dart';
import 'package:flutter_food_app/features/favorites/presentation/cubits/cubit/toggle_favorites_cubit.dart';
import 'package:flutter_food_app/features/favorites/presentation/widgets/empty_favorites_widget.dart';
import 'package:flutter_food_app/features/favorites/presentation/widgets/favorite_item_card.dart';
import 'package:flutter_food_app/features/favorites/presentation/widgets/favorites_shimmer.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favorites".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ToggleFavoritesCubit, ToggleFavoritesState>(
        listener: (context, state) {
          if (state is ToggleFavoritesLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                elevation: 1,
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        "assets/splash/Burger_Lottie_Animation..json",
                        height: 130,
                        width: 130,
                        repeat: true,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Toggle favorites loading".tr(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ToggleFavoritesSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return BlocBuilder<ToggleFavoritesCubit, ToggleFavoritesState>(
            builder: (context, state) {
              if (state is ToggleFavoritesFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ToggleFavoritesCubit>()
                              .getUserFavorites();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                        child: Text(
                          "Retry".tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is GetFavoritesLoading) {
                return buildFavoritesShimmer(context);
              }
              if (state is GetFavoritesSuccess) {
                final favorites = state.favorites.data;

                if (favorites.isEmpty) {
                  return EmptyFavorites();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ToggleFavoritesCubit>().getUserFavorites();
                  },
                  child: Column(
                    children: [
                      _buildFavoritesCount(favorites, context),

                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            return FavoriteItemCard(
                              favorite: favorites[index],
                              index: index,
                              totalItems: favorites.length,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoritesCount(
    List<FavoritesDataModel> favorites,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: favorites.length.toString(),
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: Colors.white),
              ),
              const TextSpan(text: ' ', style: TextStyle(fontSize: 24)),
              TextSpan(
                text: favorites.length == 1
                    ? 'Favorite Item'.tr()
                    : 'Favorite Items'.tr(),
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
