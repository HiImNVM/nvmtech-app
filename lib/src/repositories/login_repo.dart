import 'package:nvmtech/core/api/response.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/repositories/index.dart';
import 'package:nvmtech/src/types/login_type.dart';
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
        return LoginRepo._internal('/auth', data);
    }
  }
  

  @override
  Future<ResponseModel> login() => this
          ._apiProviderImp
          .post(this.url, data: this._data)
          .then((response) {
            if (response.statusCode != 200){
              ErrorModel(value: "Login Fail");
              return;
            }
          SuccessModel(value: "276658346");
          })
          .catchError((err) {
        printError(err);
      });
}
