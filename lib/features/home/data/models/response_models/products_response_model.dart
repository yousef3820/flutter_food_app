import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_data_model.dart';

class ProductsResponseModel {
  final int code;
  final String message;
  final List<ProductsDataModel> data;

  ProductsResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: (json[ApiKeys.data] as List)
          .map((product) => ProductsDataModel.fromJson(product))
          .toList(),
    );
  }
}
