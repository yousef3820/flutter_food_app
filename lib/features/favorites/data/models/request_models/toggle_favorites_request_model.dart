import 'package:flutter_food_app/core/network/api_endpoints.dart';

class ToggleFavoritesRequestModel {
  final int productId;

  ToggleFavoritesRequestModel({required this.productId});

  Map<String,dynamic>toJson()
  {
    return{
      ApiKeys.favoriteProductId : productId
    };
  }
}