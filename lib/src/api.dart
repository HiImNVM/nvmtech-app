import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/env.dart';
import 'package:nvmtech/src/app.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/constants/resource_constant.dart';
import 'package:nvmtech/src/models/response_error_model.dart';
import 'package:nvmtech/src/models/response_success_model.dart';
import 'package:nvmtech/src/util/print_util.dart';
import 'package:nvmtech/src/util/json_util.dart' as jsonUtil;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProviderImp implements IApiProvider, IMethod {
  Dio _dio;
  String _accessToken;

  static final ApiProviderImp _instance = ApiProviderImp._internal();
  factory ApiProviderImp() => _instance;

  ApiProviderImp._internal() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: '${Env.getDomainAPI()}',
      connectTimeout: Env.getTimeOutRequest(),
      receiveTimeout: Env.getTimeOutRequest(),
    );

    this._dio = Dio(baseOptions);
    this.setupInterceptors();
    (this._dio.transformer as DefaultTransformer).jsonDecodeCallback =
        this.parseJSON;
  }

  Future<Response> _baseAPI(String path, MethodType method,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress}) {
    switch (method) {
      case MethodType.GET:
        return this._dio.get(
              path,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,
            );

      case MethodType.POST:
        return this._dio.post(
              path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,
            );

      case MethodType.PUT:
        return this._dio.put(
              path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,
            );

      default:
        return this._dio.delete(
              path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
            );
    }
  }

  @override
  void discard() => this._accessToken = null;

  void _setRequestOptionsWithAuthen(RequestOptions options) =>
      options.headers['Authorization'] = 'bearer ' + this._accessToken;

  dynamic _onRequest(RequestOptions options) {
    if (this._accessToken == null || this._accessToken.isEmpty) {
      this._dio.lock();
      return SharedPreferencesWrapper.getInstance().then((sp) {
        final String token = sp.getToken();
        if (token != null && token.isNotEmpty) {
          printInfo('Calling with access token: $this._accessToken');
          this._setRequestOptionsWithAuthen(options);
        }

        return options;
      }).whenComplete(() => this._dio.unlock());
    }

    this._setRequestOptionsWithAuthen(options);
    return options; //continue
    // If you want to resolve the request with some custom data，
    // you can return a `Response` object or return `dio.resolve(data)`.
    // If you want to reject the request with a error message,
    // you can return a `DioError` object or return `dio.reject(errMsg)`
  }

  Future<Response> _onResponse(Response response) async {
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final data = await parseJSON(response.data);
      response.data = ResponseSuccess.fromJson(data);
      return response;
    }

    return this._dio.reject(
        DioError(response: response, error: CONST_SOMETHING_WENT_WRONG));
  }

  Future<DioError> _onError(DioError e) async {
    // Internal error
    if (e.response == null) return this._handleInternalError(e);

    // External error
    return await this._handleExternalError(e);
  }

  InterceptorsWrapper _mainHandleInterceptor() => InterceptorsWrapper(
        onRequest: this._onRequest,
        onResponse: this._onResponse,
        onError: this._onError,
      );

  @override
  void setupInterceptors() {
    // logger just log in environment dev or stag
    if (Env.appFlavor == Flavor.STAG) {
      this._dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    // main
    this._dio.interceptors.add(this._mainHandleInterceptor());
  }

  @override
  dynamic parseJSON(String text) => jsonUtil.parseJSON(text);

  @override
  Future<Response> get(String path,
          {Map<String, dynamic> queryParameters,
          Options options,
          CancelToken cancelToken,
          onReceiveProgress}) =>
      this._baseAPI(path, MethodType.GET,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

  @override
  Future<Response> post(String path,
          {dynamic data,
          Map<String, dynamic> queryParameters,
          Options options,
          CancelToken cancelToken,
          onSendProgress,
          onReceiveProgress}) =>
      this._baseAPI(path, MethodType.POST,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters);

  @override
  Future<Response> put(String path,
          {dynamic data,
          Map<String, dynamic> queryParameters,
          Options options,
          CancelToken cancelToken,
          onSendProgress,
          onReceiveProgress}) =>
      this._baseAPI(path, MethodType.PUT,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters);

  @override
  Future<Response> delete(String path,
          {dynamic data,
          Map<String, dynamic> queryParameters,
          Options options,
          CancelToken cancelToken}) =>
      this._baseAPI(path, MethodType.DELETE,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken);

  Future<void> _handleUnAuthentication() async {
    try {
      final AppBloc appBloc =
          BlocProvider.of(MyApp.navigatorKey.currentContext);
      appBloc.logout();
    } catch (e) {
      await SharedPreferencesWrapper.getInstance()
          .then((sharedPreferences) => sharedPreferences.clear());
    }
  }

  DioError _handleInternalError(DioError e) {
    if (e.error is SocketException) {
      e.response = Response(
        data: CONST_CANT_CONNECT_NETWORK,
      );
    } else if (e.error is String && e.error.indexOf('timed out') != -1) {
      e.response = Response(
        data: CONST_TIME_OUT,
      );
    } else if (e.error is HandshakeException) {
      e.response = Response(
        data: CONST_CANT_CONNECT_NETWORK,
      );
    } else {
      e.response = Response(
        data: CONST_SOMETHING_WENT_WRONG,
      );
    }

    return e;
  }

  Future<DioError> _handleExternalError(DioError e) async {
    final int statusCode = e.response.statusCode;

    // 401 is UnAuthentication
    if (statusCode == 401) {
      this._dio.lock();
      await this._handleUnAuthentication();
      this._dio.unlock();
    }

    if (e.response.data is! String) {
      printInfo('Currently, data of response is not support!');
      e.response.data = CONST_SOMETHING_WENT_WRONG;
    } else {
      final data = await parseJSON(e.response.data);
      e.response.data =
          ResponseError.fromJson(data).message ?? CONST_SOMETHING_WENT_WRONG;
    }

    return e;
  }
}
