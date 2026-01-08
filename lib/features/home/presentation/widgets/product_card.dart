import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/presentation/cubits/cubit/toggle_favorites_cubit.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_data_model.dart';
import 'package:flutter_food_app/features/product/presentation/screens/product_details.dart';
import 'package:flutter_food_app/shared/custom_text.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
  });

  final ProductsDataModel product;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ToggleFavoritesCubit, ToggleFavoritesState>(
      listener: (context, state) {
        if (state is ToggleFavoritesSuccess) {
          final updatedFavCubit = context.read<ToggleFavoritesCubit>();
          final isNowFavorite = updatedFavCubit.isFavorite(product.id);

          if (isNowFavorite != isFavorite) {
            _showFavoriteSnackBar(isFavorite: isNowFavorite, context: context);
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<CartCubit>(),
                child: ProductDetails(product: product),
              ),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    height: 160,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      height: 160,
                      color: Theme.of(context).cardColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 160,
                      color: Theme.of(context).cardColor,
                      child: const Icon(Icons.fastfood, size: 50),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Product Name
                CustomText(
                  text: product.name,
                  color: Theme.of(context).colorScheme.onSurface,
                  weight: FontWeight.w600,
                  size: 16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer(),

                // Rating and Favorite Button
                Row(
                  children: [
                    // Rating
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      product.rating,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),

                    const Spacer(),

                    // Favorite Button
                    IconButton(
                      onPressed: () {
                        final ToggleFavoritesRequestModel favorites =
                            ToggleFavoritesRequestModel(productId: product.id);

                        context.read<ToggleFavoritesCubit>().toggleFavorites(
                          favorites,
                        );
                      },
                      icon: isFavorite
                          ? Icon(
                              Icons.favorite,
                              color: Theme.of(context).colorScheme.primary,
                              size: 32,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).colorScheme.primary,
                              size: 32,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFavoriteSnackBar({
    required bool isFavorite,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        backgroundColor: isFavorite
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade600,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 26,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isFavorite
                    ? "added to favorites".tr()
                    : "removed from favorites".tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
