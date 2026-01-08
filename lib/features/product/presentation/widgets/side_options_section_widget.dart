 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/product/data/datasources/selection_manager.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_data_model.dart';
import 'package:flutter_food_app/features/product/presentation/cubits/cubit/product_details_cubit.dart';
import 'package:flutter_food_app/features/product/presentation/widgets/product_details_sideoptions_card.dart';
import 'package:flutter_food_app/features/product/presentation/widgets/shimmer_card_widget.dart';

Widget buildSideoptionsSection(
  double screenHeight,
  bool isLoading,
  bool hasError,
  List<GetSideOptionsResponseDataModel> sideoptions,
  ProductDetailsState state,
  bool isSuccess,
  BuildContext context,
  SelectionManager selectionManager,
  void Function(GetSideOptionsResponseDataModel sideOption) onSideOptionTapped,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            "side_options".tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          if (isSuccess && selectionManager.selectedSideOptionIds.isNotEmpty)
            Chip(
              label: Text(
                "selected_count".tr(
                  args: [
                    selectionManager.selectedSideOptionIds.length.toString()
                  ],
                ),
              ),
            ),
        ],
      ),
      SizedBox(height: 20),

      if (isLoading && !isSuccess)
        SizedBox(
          height: screenHeight * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => buildShimmerCard(context),
          ),
        ),

      if (hasError && state is ProductDetailsFailure)
        Container(
          height: screenHeight * 0.23,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40),
                SizedBox(height: 10),
                Text(
                  "failed_load_side_options".tr(),
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () =>
                      context.read<ProductDetailsCubit>().loadAllData(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "retry".tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

      if (isSuccess)
        SizedBox(
          height: screenHeight * 0.23,
          child: sideoptions.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.emoji_food_beverage,
                          color: Colors.grey[400],
                          size: 60,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "no_side_options".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sideoptions.length,
                  itemBuilder: (context, index) =>
                      ProductDetailsSideoptionsCard(
                    sideoptions: sideoptions[index],
                    isSelected:
                        selectionManager.isSideOptionSelected(
                      sideoptions[index].id,
                    ),
                    onTap: () =>
                        onSideOptionTapped(sideoptions[index]),
                  ),
                ),
        ),
    ],
  );
}
