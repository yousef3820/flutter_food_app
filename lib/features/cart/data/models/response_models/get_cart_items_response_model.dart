import 'package:flutter_food_app/core/network/api_endpoints.dart';

class GetCartItemsResponseModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int qunatity;
  final String price;
  final double spicy;
  final List<dynamic> toppings;
  final List<dynamic> sideoptions;

  GetCartItemsResponseModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.qunatity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideoptions,
  });

  factory GetCartItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCartItemsResponseModel(
      itemId: json[ApiKeys.cartItemId],
      productId: json[ApiKeys.productOrderId],
      name: json[ApiKeys.productName],
      image: json[ApiKeys.productImage],
      qunatity: json[ApiKeys.productOrderQuantity],
      price: json[ApiKeys.price],
      spicy:  (json[ApiKeys.productOrderSpicy] is int)
        ? (json[ApiKeys.productOrderSpicy] as int).toDouble()
        : double.tryParse(json[ApiKeys.productOrderSpicy].toString()) ?? 0.0,
      toppings: json[ApiKeys.productOrderToppings],
      sideoptions: json[ApiKeys.productOrderSideoptions],
    );
  }
}
