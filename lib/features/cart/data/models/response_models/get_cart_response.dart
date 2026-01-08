import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_response_data.dart';

class GetCartResponse {
  final int code;
  final String message;
  final GetCartResponseData data;

  GetCartResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: GetCartResponseData.fromJson(json[ApiKeys.data]),
    );
  }
}
