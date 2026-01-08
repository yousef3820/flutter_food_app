import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_data_model.dart';
import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_items_model.dart';
import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_request_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_data_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_data_model.dart';
import 'package:flutter_food_app/features/product/presentation/cubits/cubit/add_to_cart_cubit.dart';
import 'package:flutter_food_app/features/product/presentation/cubits/cubit/product_details_cubit.dart';
import 'package:flutter_food_app/features/product/data/datasources/selection_manager.dart';
import 'package:flutter_food_app/features/product/presentation/widgets/product_details_toppings_card.dart';
import 'package:flutter_food_app/features/product/presentation/widgets/shimmer_card_widget.dart';
import 'package:flutter_food_app/features/product/presentation/widgets/side_options_section_widget.dart';
import 'package:lottie/lottie.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductsDataModel product;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final SelectionManager _selectionManager = SelectionManager();
  var currentValue = 0.1;

  List<GetToppingsResponseDataModel> toppings = [];
  List<GetSideOptionsResponseDataModel> sideoptions = [];

  void _onToppingTapped(GetToppingsResponseDataModel topping) {
    setState(() {
      _selectionManager.toggleTopping(topping.id);
    });
  }

  void _onSideOptionTapped(GetSideOptionsResponseDataModel sideOption) {
    setState(() {
      _selectionManager.toggleSideOption(sideOption.id);
    });
  }

  void _onSpicyLevelChanged(double value) {
    setState(() {
      currentValue = double.parse(value.toStringAsFixed(1));
      _selectionManager.setSpicyLevel(value);
    });
  }

  Future<void> _handleAddToCart(BuildContext context) async {
    final item = AddToCartItemsModel(
      productId: widget.product.id,
      toppings: _selectionManager.selectedToppingIds,
      sideoptions: _selectionManager.selectedSideOptionIds,
      spicy: currentValue,
      quantity: 1,
    );

    final request = AddToCartRequestModel(items: [item]);

    await context.read<AddToCartCubit>().addToCart(request);
    context.read<CartCubit>().getCartData();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/splash/Added_to_cart.json',
                width: 150,
                height: 150,
                repeat: true,
              ),
              const SizedBox(height: 10),
              Text(
                "Success".tr(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "added To cart successfully".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),

              const SizedBox(height: 20),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 30,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "okay".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductDetailsCubit()..loadAllData()),
        BlocProvider(create: (_) => AddToCartCubit()),
      ],
      child: BlocListener<AddToCartCubit, AddToCartState>(
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            _showSuccessDialog(context);
          }

          if (state is AddToCartFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            bool isLoading = state is ProductDetailsAllLoading;
            bool isToppingsLoading = state is ProductDetailsToppingsLoading;
            bool isSideOptionsLoading =
                state is ProductDetailsSideoptionsLoading;
            bool isAllSuccess = state is ProductDetailsAllSuccess;
            bool isToppingsSuccess = state is ProductDetailsToppingsSuccess;
            bool isSideOptionsSuccess =
                state is ProductDetailsSideoptionssSuccess;
            bool hasError = state is ProductDetailsFailure;
            if (isAllSuccess) {
              toppings = state.toppings.data;
              sideoptions = state.sideOptions.data;
            } else if (isToppingsSuccess) {
              toppings = state.toppings.data;
            } else if (isSideOptionsSuccess) {
              sideoptions = state.sideoptions.data;
            }

            return Scaffold(
              bottomSheet: _buildBottomSheet(context),
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        elevation: 0,
                        actions: [
                          if (_selectionManager.selectedToppingIds.isNotEmpty ||
                              _selectionManager
                                  .selectedSideOptionIds
                                  .isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.clear_all),
                              onPressed: () {
                                setState(() {
                                  _selectionManager.clearSelections();
                                });
                              },
                            ),
                        ],
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            _buildProductHeader(),
                            SizedBox(height: 40),
                            _buildToppingsSection(
                              screenHeight,
                              isLoading || isToppingsLoading,
                              hasError,
                              toppings,
                              state,
                              isAllSuccess || isToppingsSuccess,
                            ),
                            SizedBox(height: 40),
                            buildSideoptionsSection(
                              screenHeight,
                              isLoading || isSideOptionsLoading,
                              hasError,
                              sideoptions,
                              state,
                              isAllSuccess || isSideOptionsSuccess,
                              context,
                              _selectionManager,
                              _onSideOptionTapped,
                            ),
                            if (_selectionManager
                                    .selectedToppingIds
                                    .isNotEmpty ||
                                _selectionManager
                                    .selectedSideOptionIds
                                    .isNotEmpty)
                              _buildSelectionSummary(),
                            SizedBox(height: 150),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isAddingToCart = context.select<AddToCartCubit, bool>(
      (cubit) => cubit.state is AddToCartLoading,
    );
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromARGB(255, 34, 33, 33)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total".tr(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text(
                '\$${widget.product.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (_selectionManager.selectedToppingIds.isNotEmpty ||
                  _selectionManager.selectedSideOptionIds.isNotEmpty)
                Text(
                  "items_selected".tr(
                    args: [
                      (_selectionManager.selectedToppingIds.length +
                              _selectionManager.selectedSideOptionIds.length)
                          .toString(),
                    ],
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
            ],
          ),
          Spacer(),
          ElevatedButton(
            onPressed: isAddingToCart ? null : () => _handleAddToCart(context),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: isAddingToCart
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    "Add to cart".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: widget.product.image,
          height: 200,
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
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              "spicy_level".tr(args: [currentValue.toString()]),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Slider(
              value: currentValue,
              min: 0.1,
              max: 1,
              divisions: 9,
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveColor: Colors.grey[300],
              thumbColor: Colors.white,
              label: currentValue.toString(),
              onChanged: _onSpicyLevelChanged,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("mild".tr(), style: TextStyle(fontSize: 16)),
                Text("hot".tr(), style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToppingsSection(
    double screenHeight,
    bool isLoading,
    bool hasError,
    List<GetToppingsResponseDataModel> toppings,
    ProductDetailsState state,
    bool isSuccess,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "toppings".tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            if (isSuccess && _selectionManager.selectedToppingIds.isNotEmpty)
              Chip(
                label: Text(
                  "selected_count".tr(
                    args: [
                      _selectionManager.selectedToppingIds.length.toString(),
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
                    "failed_to_load_toppings".tr(),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProductDetailsCubit>().loadAllData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
            child: toppings.isEmpty
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
                            "no_toppings_available".tr(),
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
                    itemCount: toppings.length,
                    itemBuilder: (context, index) => ProductDetailsToppingsCard(
                      topping: toppings[index],
                      isSelected: _selectionManager.isToppingSelected(
                        toppings[index].id,
                      ),
                      onTap: () => _onToppingTapped(toppings[index]),
                    ),
                  ),
          ),
      ],
    );
  }

  Widget _buildSelectionSummary() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Selection:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          if (_selectionManager.selectedToppingIds.isNotEmpty)
            Text(
              "topping_count".tr(
                args: [_selectionManager.selectedToppingIds.length.toString()],
              ),
              style: TextStyle(fontSize: 14),
            ),
          if (_selectionManager.selectedSideOptionIds.isNotEmpty)
            Text(
              "side_option_count".tr(
                args: [
                  _selectionManager.selectedSideOptionIds.length.toString(),
                ],
              ),
              style: TextStyle(fontSize: 14),
            ),
          if (currentValue > 0)
            Text(
              "spicy level".tr(args: [currentValue.toString()]),
              style: TextStyle(fontSize: 14),
            ),
        ],
      ),
    );
  }
}
