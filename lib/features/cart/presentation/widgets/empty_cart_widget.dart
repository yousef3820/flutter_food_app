import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:lottie/lottie.dart';

Widget buildEmptyCart(BuildContext context) {
  return RefreshIndicator(
    onRefresh: () async {
      context.read<CartCubit>().getCartData();
    },
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/splash/Empty_Cart.json", repeat: true),

            SizedBox(height: 20),

            Text(
              "Your cart is empty".tr(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Empty cart details".tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}
