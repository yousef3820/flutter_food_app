import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/home/presentation/widgets/shimmer_product_card_widget.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerHomeScreen(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: CustomScrollView(
      slivers: [
        // ---------------- SHIMMER HEADER ----------------
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Logo shimmer
                Container(
                  width: 350,
                  height: 30,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 18),
                // Greeting shimmer
                Container(
                  width: 250,
                  height: 30,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 15),

                // ---------------- SHIMMER SEARCH BAR ----------------
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        const SliverPadding(padding: EdgeInsets.only(top: 20)),

        // ---------------- SHIMMER PRODUCT GRID ----------------
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return buildShimmerProductCard(baseColor);
            }, childCount: 6),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.61,
            ),
          ),
        ),
      ],
    ),
  );
}
