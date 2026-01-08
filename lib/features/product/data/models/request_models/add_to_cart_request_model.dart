import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_items_model.dart';

class AddToCartRequestModel {
  final List<AddToCartItemsModel> items;

  AddToCartRequestModel({required this.items});

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((item) => item.tojson()).toList(),
    };
  }
}
