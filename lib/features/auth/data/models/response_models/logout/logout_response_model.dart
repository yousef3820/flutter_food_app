import 'package:flutter_food_app/core/network/api_endpoints.dart';

class LogoutResponseModel {
  final int code;
  final String message;
  final Map<String, dynamic>? data;

  LogoutResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: json[ApiKeys.data],
    );
  }
}
