import 'package:flutter_food_app/core/network/api_endpoints.dart';

class ProfileDataResponse {
  final String name;
  final String email;
  final String image;
  final String? address;
  final String? visa;

  ProfileDataResponse({
    required this.name,
    required this.email,
    required this.image,
    required this.address,
    required this.visa,
  });

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDataResponse(
      name: json[ApiKeys.name],
      email: json[ApiKeys.email],
      image: json[ApiKeys.image],
      address: json[ApiKeys.address],
      visa: json[ApiKeys.visa],
    );
  }
}
