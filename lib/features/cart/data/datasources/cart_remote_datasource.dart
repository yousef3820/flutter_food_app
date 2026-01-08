import 'package:flutter_food_app/core/network/api_consumer.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/delete_from_cart_response_model.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_response.dart';

class CartRemoteDatasource {
  final ApiConsumer api;

  CartRemoteDatasource({required this.api});

  Future<GetCartResponse> getCartData() async {
    final response = await api.get("${ApiEndpoints.getCart}");
    return GetCartResponse.fromJson(response);
  }

  Future<DeleteFromCartResponseModel> deleteFromCart(int id) async {
    final response = await api.delete("${ApiEndpoints.deleteFromCart}/${id}");
    return DeleteFromCartResponseModel.fromJson(response);
  }
}
