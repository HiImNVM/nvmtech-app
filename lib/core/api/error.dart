import 'package:dio/dio.dart';

class NotFoundResponse extends DioError {
  final dynamic error;
  NotFoundResponse({
    this.error,
  }) : super(error: error);
}
