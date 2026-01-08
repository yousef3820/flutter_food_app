import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_items_response_model.dart';

class GetCartResponseData {
  final int id;
  final String totalPrice;
  final List<GetCartItemsResponseModel> items;

  GetCartResponseData({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory GetCartResponseData.fromJson(Map<String, dynamic> json) {
    return GetCartResponseData(
      id: json[ApiKeys.cartOrderId],
      totalPrice: json[ApiKeys.totalPrice],
      items: (json[ApiKeys.cartOrderItems] as List)
          .map((item) => GetCartItemsResponseModel.fromJson(item))
          .toList(),
    );
  }
}
