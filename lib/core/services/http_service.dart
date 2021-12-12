import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sigma_assigment/core/config/api_config.dart';
import 'package:sigma_assigment/core/services/snack_bar_service.dart';

class HttpService {
  Dio dio = Dio();

  HttpService() {
    initInterceptor();
  }

  late String contentTypeHeader;
  Future<void> initInterceptor() async {
    print("init interceptor");
    try {
      dio = Dio();

     

      dio.interceptors.add(
        InterceptorsWrapper(
          onError: (e, handler) {
            if (e.response != null) {
              Snack.showSnackBar(message: e.message);
              return handler.next(e);
            }
          },
          onRequest: (RequestOptions options, handler) async {
            Map<String, String> headers = {
              HttpHeaders.contentTypeHeader: "application/json",
            };

            return handler.next(options);
          },
          onResponse: (response, handler) {
            // Do something with response data
            return handler.next(response);
            // If you want to reject the request with a error message,
            // you can reject a `DioError` object eg: `handler.reject(dioError)`
          },
        ),
      );
    } on DioError catch (e) {
      Snack.showSnackBar(message: e.message);
    }
  }

  Future<Response> httpGet(
      {required String url, Map<String, dynamic>? data}) async {
    final httpResult = await dio.get(Api.baseUrl + url, queryParameters: data);

    return httpResult;
    // if (apiResult.hasError == true) {
    //   throw CustomException(apiResult.message);
    // } else {
    //   return apiResult;
    // }
  }

  Future<Response> httpGetCustom(
      {required String url, Map<String, dynamic>? data}) async {
    final httpResult = await dio.get(url, queryParameters: data);

    return httpResult;
    // if (apiResult.hasError == true) {
    //   throw CustomException(apiResult.message);
    // } else {
    //   return apiResult;
    // }
  }

  Future<Response<dynamic>> httpPost(
      {required String url, required dynamic data}) async {
    final httpResult = await dio.post(Api.baseUrl + url, data: data);

    return httpResult;
    // if (apiResult.hasError == true) {
    //   throw CustomException(apiResult.message);
    // } else {
    //   return apiResult;
    // }
  }
}
