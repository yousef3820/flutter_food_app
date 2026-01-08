import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/register/register_data_response.dart';

class RegisterResponseModel {
  final String code;
  final String message;
  final RegisterDataResponse data;

  RegisterResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: RegisterDataResponse.fromJson(json[ApiKeys.data]),
    );
  }
}
