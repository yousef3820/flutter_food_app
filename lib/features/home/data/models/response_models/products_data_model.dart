import 'package:flutter_food_app/core/network/api_endpoints.dart';

class ProductsDataModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;

  ProductsDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) {
    return ProductsDataModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.productName],
      description: json[ApiKeys.description],
      image: json[ApiKeys.productImage],
      rating: json[ApiKeys.rating],
      price: json[ApiKeys.price],
    );
  }
}
