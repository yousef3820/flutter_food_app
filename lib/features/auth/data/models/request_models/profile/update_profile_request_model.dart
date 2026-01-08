import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';

class UpdateProfileRequestModel {
  final String email;
  final String name;
  final String address;
  final File? image;

  UpdateProfileRequestModel({
    required this.email,
    required this.name,
    required this.address,
    required this.image,
  });

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      ApiKeys.email: email,
      ApiKeys.address: address,
      ApiKeys.name: name,
    });

    if (image != null && image!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        ApiKeys.image,
        await MultipartFile.fromFile(
          image!.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      ));
    }

    return formData;
  }
}