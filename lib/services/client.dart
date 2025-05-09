import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/services/app_interceptors.dart';

import 'package:weatherly/services/endpoints.dart';
part 'client.g.dart';

class DioClient {
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.BASEURL
      ..options.connectTimeout = const Duration(
        seconds: Endpoints.CONNECTIONTIMEOUT,
      )
      ..options.receiveTimeout = const Duration(
        seconds: Endpoints.CONNECTIONTIMEOUT,
      )
      ..options.responseType = ResponseType.json
      ..interceptors.add(AppInterceptors());
  }
  // dio instance
  final Dio _dio;

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return response;
  }
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio();
}

@Riverpod(keepAlive: true)
DioClient dioClient(Ref ref) {
  return DioClient(ref.read(dioProvider));
}
