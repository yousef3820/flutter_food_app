import 'package:flutter_food_app/core/network/api_endpoints.dart';

class RegisterDataResponse {
  final String token;
  final String name;
  final String email;
  final String image;

  RegisterDataResponse({
    required this.token,
    required this.name,
    required this.email,
    required this.image,
  });

  factory RegisterDataResponse.fromJson(Map<String, dynamic> json) {
    return RegisterDataResponse(
      token: json[ApiKeys.token],
      name: json[ApiKeys.name],
      email: json[ApiKeys.email],
      image: json[ApiKeys.image],
    );
  }
}
