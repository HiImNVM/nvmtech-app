import 'package:dio/dio.dart';
import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/env.dart';
import 'package:nvmtech/src/app.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/util/printUtil.dart';
import 'package:nvmtech/src/util/jsonUtil.dart' as jsonUtil;

class ApiProviderImp implements IApiProvider, IMethod {
  Dio _dio;
  String _accessToken;

  static final ApiProviderImp _instance = ApiProviderImp._internal();
  factory ApiProviderImp() => _instance;

  ApiProviderImp._internal() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: '${Env.getDomainAPI()}',
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
      return SharedPreferencesWrapper.getInstance()
          .then((sp) {
            final String token = sp.getToken();
            if (token != null && token.isNotEmpty) {
              printInfo('Calling with access token: $this._accessToken');
              this._setRequestOptionsWithAuthen(options);
            }

            return options;
          })
          .whenComplete(() => this._dio.unlock())
          .catchError((err) => printError('onRequest -> $err'));
    }

    this._setRequestOptionsWithAuthen(options);
    return options; //continue
    // If you want to resolve the request with some custom data，
    // you can return a `Response` object or return `dio.resolve(data)`.
    // If you want to reject the request with a error message,
    // you can return a `DioError` object or return `dio.reject(errMsg)`
  }

  dynamic _onResponse(Response response) async {
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      response.data = await parseJSON(response.data);
      return response;
    }

    return this._dio.reject(DioError(
        response: response, error: 'Something went wrong. Please try again!'));
  }

  dynamic _onError(DioError e) async {
    if (e.response == null) return e;

    // 401 is UnAuthentication
    final int statusCode = e.response.statusCode;

    if (statusCode == 401) {
      this._dio.lock();
      await this._handleUnAuthentication();
      this._dio.unlock();
    }

    printError(
        'Fail API:\n-URL: ${e.response.request.uri}\n-StatusCode: ${e.response.statusCode}\n-Body: ${e.response.data}');

    if (e.response.data is String) {
      e.response.data = await parseJSON(e.response.data);
    }

    return e;
  }

  InterceptorsWrapper _beforeRequest() => InterceptorsWrapper(
        onRequest: this._onRequest,
        onResponse: this._onResponse,
        onError: this._onError,
      );

  @override
  void setupInterceptors() => this._dio.interceptors.add(this._beforeRequest());

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
      printError(e);
      await SharedPreferencesWrapper.getInstance()
          .then((sharedPreferences) => sharedPreferences.clear());
    }
  }
}
