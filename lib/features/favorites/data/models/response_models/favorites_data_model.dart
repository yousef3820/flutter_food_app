import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_data_model.dart';

class FavoritesDataModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;
  final bool isFavorite;

  FavoritesDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
    required this.isFavorite,
  });

  factory FavoritesDataModel.formJson(Map<String, dynamic> json) {
    return FavoritesDataModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.name],
      description: json[ApiKeys.description],
      image: json[ApiKeys.image],
      rating: json[ApiKeys.rating],
      price: json[ApiKeys.price],
      isFavorite: json["is_favorite"],
    );
  }
  ProductsDataModel toProductModel() {
    return ProductsDataModel(
      id: this.id,
      name: this.name,
      image: this.image,
      price: this.price,
      rating: this.rating,
      description: this.description, // Add if available
      // Add other required properties
    );
  }
}
