import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_data_model.dart';

class ProductDetailsSideoptionsCard extends StatelessWidget {
  const ProductDetailsSideoptionsCard({
    super.key,
    required this.sideoptions,
    required this.isSelected,
    required this.onTap,
  });

  final GetSideOptionsResponseDataModel sideoptions;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        child: Card(
          margin: EdgeInsets.only(right: 20),
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.black,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          elevation: isSelected ? 4 : 1,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: sideoptions.image,
                        height: 100,
                        placeholder: (context, url) => Container(
                          height: 100,
                          color: Theme.of(context).cardColor,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 100,
                          color: Theme.of(context).cardColor,
                          child: const Icon(Icons.fastfood, size: 50),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            sideoptions.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Icon(
                          isSelected ? Icons.check_circle : Icons.add_circle,
                          color: isSelected ? Colors.white : Colors.red,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Selection indicator
              if (isSelected)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
