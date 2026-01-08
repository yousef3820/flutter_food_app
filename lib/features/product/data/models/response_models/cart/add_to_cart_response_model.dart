import 'package:flutter_food_app/core/network/api_endpoints.dart';

class AddToCartResponseModel {
  final int code;
  final String message;
  final Map<String, dynamic>? data;

  AddToCartResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: json[ApiKeys.data],
    );
  }
}
