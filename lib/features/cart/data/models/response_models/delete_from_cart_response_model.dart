import 'package:flutter_food_app/core/network/api_endpoints.dart';

class DeleteFromCartResponseModel {
  final int code;
  final String message;
  final Map<String, dynamic>? data;

  DeleteFromCartResponseModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory DeleteFromCartResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteFromCartResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: json[ApiKeys.data],
    );
  }
}
