import 'package:nvmtech/core/api/response.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/models/response_error_model.dart';
import 'package:nvmtech/src/models/response_success_model.dart';
import 'package:nvmtech/src/modules/login/login_constant.dart';
import 'package:nvmtech/src/repositories/index.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:nvmtech/src/util/jsonUtil.dart';
import 'package:nvmtech/src/util/printUtil.dart';

abstract class ILoginRepo {
  Future<ResponseModel> login();
}

class LoginRepo implements IRepo, ILoginRepo {
  final ApiProviderImp _apiProviderImp = ApiProviderImp();
  dynamic _data;
  AppBloc appBloc;
  @override
  String url;

  LoginRepo._internal(this.url, this._data);
  factory LoginRepo(LoginType loginType, dynamic data) {
    switch (loginType) {
      case LoginType.FB:
        return LoginRepo._internal('/auth/fb', data);
      default:
        return LoginRepo._internal('/login', data);
    }
  }

  @override
  Future<ResponseModel> login() => this
          ._apiProviderImp
          .post(this.url, data: this._data)
          .then((response) async {
        dynamic body = await parseJSON(response.data);

        if (response.statusCode != 200) {
          return ErrorModel(value: ResponseError.fromJson(body));
        }

        return SuccessModel(value: ResponseSuccess.fromJson(body));
      }).catchError((err) {
        printError(err);
        return ErrorModel(value: ResponseError.fromJson(err.error));
      });
}
