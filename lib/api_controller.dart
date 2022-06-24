import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiController {
  static String url = "http://localhost:5007/api";

  static late final Dio dio;

  static void initializeAPIController() {
    dio = Dio();
    dio.options.baseUrl = url;
    initializeInterceptors();
  }

  static initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
        // onError: (DioError error, handler) {
        //   Data.globalError(context, "a fatal error occurred");
        //   if (kDebugMode) {
        //     print(error.message);
        //   }
        // },
        ));
  }

  static Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParams, bool showErrorToast = true}) async {
    try {
      final response = await dio.get(url, queryParameters: queryParams);
      return response;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      onError(e, 'get');
    }
  }

  static Future<dynamic> post(String url,
      {Map<String, dynamic>? queryParams, data}) async {
    try {
      final response =
          await dio.post(url, queryParameters: queryParams, data: data);

      //print(response.requestOptions.headers.toString());

      return response;
    } on DioError catch (e) {
      onError(e, 'post');
    }
  }

  static Future<dynamic> delete(String url,
      {Map<String, dynamic>? queryParams, data}) async {
    try {
      final response =
          await dio.delete(url, queryParameters: queryParams, data: data);
      return response.data;
    } on DioError catch (e) {
      onError(e, 'delete');
    }
  }

  static void onError(DioError e, String method) {
    if (kDebugMode) {
      print(
          'Exception in $method ${e.requestOptions.uri} ${e.requestOptions.queryParameters} ${e.requestOptions.data} ${e.requestOptions.headers} $e');
    }
    if (kDebugMode) {
      print(e.response?.data);
    }
    throw e;
  }

// static Future<dynamic> put(String url,
//     {Map<String, dynamic>? queryParams, data}) async {
//   try {
//     print('$url ${data.toString()}');
//
//     final response =
//     await dio.put(url, queryParameters: queryParams, data: data);
//     return response.data;
//   } on DioError catch (e) {
//     //onError(e, 'put');
//   }
// }
}
