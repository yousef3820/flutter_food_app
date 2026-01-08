import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/favorites/data/models/response_models/favorites_data_model.dart';

class GetUserFavoritesModel {
  final int code;
  final String message;
  final List<FavoritesDataModel> data;

  GetUserFavoritesModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetUserFavoritesModel.fromJson(Map<String, dynamic> json) {
    return GetUserFavoritesModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: (json[ApiKeys.data] as List)
          .map((favorite) => FavoritesDataModel.formJson(favorite))
          .toList(),
    );
  }
}
