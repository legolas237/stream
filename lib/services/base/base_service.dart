import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:stream/config/hooks.dart';
import 'package:stream/repository/storage_repository.dart';

class ApiClient {
  ApiClient() {
    baseUrl = DioOptions.baseUrl();
    _httpClient = Dio(DioOptions.baseOptions());
    _httpClient!.interceptors.add(InterceptorWrapper());
  }

  String? baseUrl;
  Dio? _httpClient;

  Dio get httpClient => _httpClient!;
}

class InterceptorWrapper extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("***** ${options.method}::${options.path}");
    if(options.data is! FormData){
      Hooks.prettyJson(options.data);
    }

    // Authorization
    if(! options.headers.containsKey("Authorization")){
      final accessToken = StorageRepository.getToken();
      if(accessToken != null){
        options.headers['Authorization'] = "Bearer $accessToken";
      }
    }

    options.headers['content-type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("***** End http");
    Hooks.prettyJson(response.data);
    response.data = Hooks.decodeJson(response.data);

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(err.toString());
    if (err.response != null) {
      Hooks.prettyJson(err.response!.data.toString());
    }

    return super.onError(err, handler);
  }
}

class DioOptions {
  static String baseUrl() {
    const envApiUrl = String.fromEnvironment("OSM_API_URL");
    return envApiUrl.replaceFirst(
      '{2}',
      StorageRepository.getLanguage().toLowerCase(),
    );
  }

  static BaseOptions baseOptions() {
    return BaseOptions(
        baseUrl: DioOptions.baseUrl(),
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000 // 60 seconds
    );
  }
}

