import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_items_response_model.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});
  final GetCartItemsResponseModel item;

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: item.image,
                    height: 130,
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
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Icon(Icons.add, size: 25, color: Colors.white),
                      ),
                      Text(
                        item.qunatity.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 17,vertical: 18)
                    ),
                    onPressed: () {
                      context.read<CartCubit>().deleteFromCart(item.itemId);
                    },
                    child: Text(
                      "remove from cart".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
