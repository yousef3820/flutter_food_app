import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:flutter_food_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter_food_app/features/cart/presentation/widgets/cart_items_shimmer..dart';
import 'package:flutter_food_app/features/cart/presentation/widgets/empty_cart_widget.dart';
import 'package:flutter_food_app/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is DeleteCartItemLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 1,
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/splash/Burger_Lottie_Animation..json",
                      height: 130,
                      width: 130,
                      repeat: true,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Removing cart item".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is DeleteCartItemSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart items".tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is GetCartDataSuccess) {
              List<int> itemsIDs = state.cartDetails.data.items
                  .map((item) => item.itemId)
                  .toList();
              final totalPrice = state.cartDetails.data.items.fold<double>(
                0.0,
                (sum, item) =>
                    sum + (double.tryParse(item.price) ?? 0) * item.qunatity,
              );
              if (state.cartDetails.data.items.isEmpty) {
                return buildEmptyCart(context);
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CartCubit>().getCartData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return CartItem(
                              item: state.cartDetails.data.items[index],
                            );
                          },
                          itemCount: state.cartDetails.data.items.length,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total".tr(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '\$${totalPrice}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<CartCubit>(),
                                    child: CheckoutScreen(
                                      totalPrice: totalPrice,
                                      ordersId: itemsIDs,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Checkout".tr(),
                              style: Theme.of(context).textTheme.displaySmall!
                                  .copyWith(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is GetCartDataLoading || state is ClearCartLoading) {
              return buildHomeCartItemsShimmer();
            }

            if (state is CartFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().getCartData();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        "Retry".tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }
            return buildHomeCartItemsShimmer();
          },
        ),
      ),
    );
  }
}
