import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_data_response.dart';

class ProfileResponseModel {
  final int code;
  final String message;
  final ProfileDataResponse data;

  ProfileResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProfileResponseModel.formjson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
      data: ProfileDataResponse.fromJson(json[ApiKeys.data]),
    );
  }
}
