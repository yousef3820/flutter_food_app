 import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cartItemShimmer(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              /// LEFT SIDE (image + title + subtitle)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(height: 130, width: 130, color: Colors.white),
                  const SizedBox(height: 10),

                  // Title placeholder
                  Container(height: 15, width: 100, color: Colors.white),
                  const SizedBox(height: 5),

                  // Subtitle placeholder
                  Container(height: 15, width: 80, color: Colors.white),
                ],
              ),

              const SizedBox(width: 20),

              /// RIGHT SIDE (qty buttons + button)
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // + button placeholder
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        ),

                        // quantity placeholder
                        Container(height: 20, width: 20, color: Colors.white),

                        // - button placeholder
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Add to cart button placeholder
                    Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }