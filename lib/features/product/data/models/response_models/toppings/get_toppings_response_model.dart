import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_data_model.dart';

class GetToppingsResponseModel {
  final int code;
  final String message;
  final List<GetToppingsResponseDataModel> data;

  GetToppingsResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetToppingsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetToppingsResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: (json[ApiKeys.data] as List)
          .map((topping) => GetToppingsResponseDataModel.fromJson(topping))
          .toList(),
    );
  }
}
