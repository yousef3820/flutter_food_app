import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/favorites/data/models/request_models/toggle_favorites_request_model.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/favorites_data_model.dart';
import 'package:flutter_food_app/features/favorites/presentation/cubits/cubit/toggle_favorites_cubit.dart';
import 'package:flutter_food_app/features/product/presentation/screens/product_details.dart';

class FavoriteItemCard extends StatelessWidget {
  final FavoritesDataModel favorite;
  final int index;
  final int totalItems;

  const FavoriteItemCard({
    super.key,
    required this.favorite,
    required this.index,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: index == totalItems - 1 ? 16 : 12),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(
                  product: favorite.toProductModel(),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      width: 100,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: favorite.image,
                          placeholder: (context, url) => Container(
                            color: Theme.of(context).cardColor,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Theme.of(context).cardColor,
                            child: Icon(
                              Icons.fastfood,
                              size: 40,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha:  0.3),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name and Favorite Button
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      favorite.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    
                                    // Rating moved here - next to product name
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                          color: Colors.amber[700],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          favorite.rating,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Favorite Button
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 50,
                                ),
                                onPressed: () {
                                  context
                                      .read<ToggleFavoritesCubit>()
                                      .toggleFavorites(
                                        ToggleFavoritesRequestModel(
                                          productId: favorite.id,
                                        ),
                                      );
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Delicious and fresh".tr(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[500],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Price and Category (if available)
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "\$${favorite.price}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Action Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                product: favorite.toProductModel(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 22,
                        ),
                        label: Text(
                          "View Details".tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
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
}