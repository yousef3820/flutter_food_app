import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/favorites/presentation/cubits/cubit/toggle_favorites_cubit.dart';
import 'package:flutter_food_app/features/favorites/presentation/widgets/favorites_item_shimmer.dart';
import 'package:shimmer/shimmer.dart';

Widget buildFavoritesShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ToggleFavoritesCubit>().getUserFavorites();
      },
      child: Column(
        children: [
          /// Favorites count shimmer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          /// Favorites list shimmer
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: 6,
              itemBuilder: (context, index) => favoriteItemShimmer(context),
            ),
          ),
        ],
      ),
    );
  }