import 'dart:async';

import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/src/api.dart';
import 'package:nvmtech/src/models/response_error_model.dart';
import 'package:nvmtech/src/models/response_success_model.dart';

abstract class IForgotPasswordRepo {
  Future<ResponseModel> sendVerificationCode();
  Future<ResponseModel> checkVerificationCode();
}

class ForgotPassword implements IRepo, IForgotPasswordRepo {
  final ApiProviderImp _apiProviderImp = ApiProviderImp();

  @override
  var data;

  @override
  String url;

  ForgotPassword._internal(this.url, this.data);
  factory ForgotPassword(dynamic data) =>
      ForgotPassword._internal('/sms/verificationCode', data);

  @override
  Future<ResponseModel> sendVerificationCode() async {
    try {
      final response =
          await this._apiProviderImp.post(this.url + '/send', data: this.data);

      return SuccessModel(value: ResponseSuccess.fromJson(response.data));
    } catch (err) {
      return ErrorModel(value: ResponseError.fromJson(err.response.data));
    }
  }

  @override
  Future<ResponseModel> checkVerificationCode() async {
    try {
      final response =
          await this._apiProviderImp.post(this.url + '/check', data: this.data);

      return SuccessModel(value: ResponseSuccess.fromJson(response.data));
    } catch (err) {
      return ErrorModel(value: ResponseError.fromJson(err.response.data));
    }
  }
}
