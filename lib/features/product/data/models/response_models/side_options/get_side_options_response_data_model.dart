import 'package:flutter_food_app/core/network/api_endpoints.dart';

class GetSideOptionsResponseDataModel {
  final int id;
  final String name;
  final String image;

  GetSideOptionsResponseDataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GetSideOptionsResponseDataModel.fromJson(Map<String, dynamic> json) {
    return GetSideOptionsResponseDataModel(
      id: json[ApiKeys.toppingsId],
      name: json[ApiKeys.toppingsName],
      image: json[ApiKeys.toppingsImage],
    );
  }
}
