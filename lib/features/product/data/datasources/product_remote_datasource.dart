import 'package:flutter_food_app/core/network/api_consumer.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_request_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/cart/add_to_cart_response_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_model.dart';

class ProductRemoteDatasource {
  final ApiConsumer api;

  ProductRemoteDatasource({required this.api});

  Future<GetToppingsResponseModel> getToppings() async {
    final response = await api.get("${ApiEndpoints.toppings}");
    return GetToppingsResponseModel.fromJson(response);
  }

  Future<GetSideOptionsResponseModel> getSideoptions() async {
    final response = await api.get("${ApiEndpoints.sideOptions}");
    return GetSideOptionsResponseModel.fromJson(response);
  }

  Future<AddToCartResponseModel> addTocart(
    AddToCartRequestModel addTocart,
  ) async {
    final response = await api.post(
      "${ApiEndpoints.addTocart}",
      data: addTocart.toJson(),
    );
    return AddToCartResponseModel.fromJson(response);
  }
}
