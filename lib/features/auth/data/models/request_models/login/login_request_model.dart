import 'package:flutter_food_app/core/network/api_endpoints.dart';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String ,dynamic> toJson()
  {
    return {
      ApiKeys.email : email,
      ApiKeys.password : password
    };
  }
}