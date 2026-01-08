import 'package:flutter_food_app/core/network/api_endpoints.dart';

class ToggleFavoritesReponseModel {
  final int code;
  final String message;
  final Map<String, dynamic>? data;

  ToggleFavoritesReponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ToggleFavoritesReponseModel.fromJson(Map<String, dynamic> json) {
    return ToggleFavoritesReponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: json[ApiKeys.data],
    );
  }
}
