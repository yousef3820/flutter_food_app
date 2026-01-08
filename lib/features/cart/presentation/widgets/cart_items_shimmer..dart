import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/cart/presentation/widgets/cart_item_shimmer.dart';

Widget buildHomeCartItemsShimmer() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => cartItemShimmer(context),
    ),
  );
}
