import 'package:flutter_food_app/core/network/api_endpoints.dart';

class GetToppingsResponseDataModel {
  final int id;
  final String name;
  final String image;

  GetToppingsResponseDataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GetToppingsResponseDataModel.fromJson(Map<String, dynamic> json) {
    return GetToppingsResponseDataModel(
      id: json[ApiKeys.toppingsId],
      name: json[ApiKeys.toppingsName],
      image: json[ApiKeys.toppingsImage],
    );
  }
}
