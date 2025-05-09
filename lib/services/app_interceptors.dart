import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors();

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers = {};

    super.onRequest(options, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      super.onError(err, handler);
      // final errorMessage = DioExceptions.fromDioError(err).toString();

      return handler.next;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
