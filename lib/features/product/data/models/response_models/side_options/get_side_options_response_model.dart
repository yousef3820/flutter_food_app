import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_data_model.dart';

class GetSideOptionsResponseModel {
  final int code;
  final String message;
  final List<GetSideOptionsResponseDataModel> data;

  GetSideOptionsResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetSideOptionsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSideOptionsResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: (json[ApiKeys.data] as List)
          .map((topping) => GetSideOptionsResponseDataModel.fromJson(topping))
          .toList(),
    );
  }
}
