import 'package:dio/dio.dart';
export './response.dart';

abstract class IApiProvider {
  dynamic parseJSON(String text);
  void setupInterceptors();
  void discard();
}

enum MethodType {
  GET,
  POST,
  PUT,
  DELETE,
}

abstract class IMethod {
  Future<Response> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  });

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  });
}

abstract class IRepo {
  String url;
  dynamic data;
}
