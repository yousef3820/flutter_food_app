import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/errors/error_model.dart';
import 'package:flutter_food_app/core/network/api_consumer.dart';
import 'package:flutter_food_app/core/network/api_endpoints.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = ApiEndpoints.baseUrl;

    // ❗ DON'T wipe headers
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) => status! < 500;

    dio.interceptors.add(
      PrettyDioLogger(error: true, responseBody: true, requestBody: true),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final LocalDatasource localDatasource = locator<LocalDatasource>();
          final token = await localDatasource.retrieveSecureData("token");

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }
  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParametes,
  }) async {
    try {
      final result = await dio.delete(
        path,
        data: data,
        queryParameters: queryParametes,
      );
      return result.data;
    } on DioException catch (e) {
      handleExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParametes,
  }) async {
    try {
      final result = await dio.get(
        path,
        data: data,
        queryParameters: queryParametes,
      );
      return result.data;
    } on DioException catch (e) {
      handleExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParametes,
  }) async {
    try {
      final result = await dio.patch(
        path,
        data: data,
        queryParameters: queryParametes,
      );
      return result.data;
    } on DioException catch (e) {
      handleExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParametes,
  }) async {
    try {
      final result = await dio.post(
        path,
        data: data,
        queryParameters: queryParametes,
      );
      return result.data;
    } on DioException catch (e) {
      handleExceptions(e);
    }
  }
}
