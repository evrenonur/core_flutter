import 'package:core_flutter/core/endpoints.dart';
import 'package:core_flutter/utils/storage_manager.dart';
import 'package:dio/dio.dart';


class NetworkManager with StorageManager {

  static NetworkManager? _instance = NetworkManager._init();
  static NetworkManager get instance => _instance!;
  NetworkManager._init();

  final Dio _dio = Dio();
  NetworkManager() {
    _dio.options.baseUrl = Endpoints.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    _dio.options.validateStatus = (status) => status! < 500;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await getData('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            //Todo: Handle 401
          }
          return handler.next(response);
        },
      ),
    );
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }


}
