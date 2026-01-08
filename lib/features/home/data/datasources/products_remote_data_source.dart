import 'package:flutter_food_app/core/network/api_consumer.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_response_model.dart';

class ProductsRemoteDataSource {
  final ApiConsumer api;

  ProductsRemoteDataSource({required this.api});

  Future<ProductsResponseModel> getAllProducts() async {
    final response = await api.get("${ApiEndpoints.products}");
    return ProductsResponseModel.fromJson(response);
  }
}
