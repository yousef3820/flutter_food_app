import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/login/login_data_response.dart';

class LoginResponseModel {
  final int code;
  final String message;
  final LoginDataResponse? data;

  LoginResponseModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: json[ApiKeys.data] != null ? LoginDataResponse.fromJson(json[ApiKeys.data]) : null,
    );
  }
}
