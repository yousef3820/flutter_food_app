import 'package:flutter_food_app/core/network/api_endpoints.dart';

class RegisterRequestModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? imageBase64;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.imageBase64,
  });
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name : name,
      ApiKeys.email: email,
      ApiKeys.phone: phone,
      ApiKeys.password: password,
      ApiKeys.image: imageBase64,
    };
  }
}
