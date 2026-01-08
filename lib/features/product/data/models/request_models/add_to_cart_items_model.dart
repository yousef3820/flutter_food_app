import 'package:flutter_food_app/core/network/api_endpoints.dart';

class AddToCartItemsModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int>? toppings;
  final List<int>? sideoptions;

  AddToCartItemsModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    this.toppings,
    this.sideoptions,
  });

  Map<String, dynamic> tojson() {
    return {
      ApiKeys.productOrderId: productId,          // <-- FIXED
      ApiKeys.productOrderQuantity: quantity,
      ApiKeys.productOrderSpicy: spicy,
      ApiKeys.productOrderToppings: toppings ?? [],
      ApiKeys.productOrderSideoptions: sideoptions ?? [],
    };
  }
}
