import 'package:flutter_food_app/core/errors/error_model.dart';
import 'package:flutter_food_app/core/errors/srever_failure.dart';
import 'package:flutter_food_app/core/network/api_consumer.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/login/login_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/profile/update_profile_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/register/register_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/login/login_reponse_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/logout/logout_response_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_response_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/update_profile/update_profile_response_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/register/register_response_model.dart';

class RemoteDatasource {
  final ApiConsumer api;

  RemoteDatasource({required this.api});

  Future<RegisterResponseModel> registerUser(
    RegisterRequestModel registerUser,
  ) async {
    final response = await api.post(
      "${ApiEndpoints.register}",
      data: registerUser.toJson(),
    );
    if (response[ApiKeys.data] == null) {
      throw ServerException(errorModel: ErrorModel.fromjson(response));
    }
    return RegisterResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> loginUser(LoginRequestModel loginUser) async {
    final response = await api.post(
      "${ApiEndpoints.login}",
      data: loginUser.toJson(),
    );
    if (response[ApiKeys.data] == null) {
      throw ServerException(errorModel: ErrorModel.fromjson(response));
    }

    return LoginResponseModel.fromJson(response);
  }

  Future<ProfileResponseModel> getProfileData() async {
    final response = await api.get("${ApiEndpoints.profile}");
    if (response[ApiKeys.data] == null) {
      throw ServerException(errorModel: ErrorModel.fromjson(response));
    }
    return ProfileResponseModel.formjson(response);
  }

  Future<UpdateProfileResponseModel> updateProfileData(
    UpdateProfileRequestModel updateProfile,
  ) async {
    // Await the FormData creation
    final formData = await updateProfile.toFormData();

    final response = await api.post(
      "${ApiEndpoints.updateProfile}",
      data: formData, // Pass the actual FormData, not the Future
    );
    if (response[ApiKeys.data] == null) {
      throw ServerException(errorModel: ErrorModel.fromjson(response));
    }
    return UpdateProfileResponseModel.formjson(response);
  }

  Future<LogoutResponseModel> logout() async {
    final response = await api.post("${ApiEndpoints.logout}");
    if (response[ApiKeys.code] != 200) {
      throw ServerException(errorModel: ErrorModel.fromjson(response));
    }
    return LogoutResponseModel.fromJson(response);
  }
}
