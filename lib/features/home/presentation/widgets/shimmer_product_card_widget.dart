import 'package:flutter/material.dart';

Widget buildShimmerProductCard(Color baseColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image shimmer
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),

          // Product name shimmer
          Container(width: 120, height: 20, color: baseColor),
          const SizedBox(height: 5),

          // Product description shimmer
          Container(width: double.infinity, height: 15, color: baseColor),
          const SizedBox(height: 8),

          // Product price and button row shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 60, height: 20, color: baseColor),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: baseColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }