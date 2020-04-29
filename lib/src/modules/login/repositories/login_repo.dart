import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/src/api.dart';
import 'package:nvmtech/src/modules/login/models/loginWithEmail_model.dart';
import 'package:nvmtech/src/modules/login/types/login_type.dart';

abstract class ILoginRepo {
  Future<ResponseModel> login();
}

class LoginRepo implements IRepo, ILoginRepo {
  final ApiProviderImp _apiProviderImp = ApiProviderImp();

  @override
  var data;

  @override
  String url;

  LoginRepo._internal(this.url, this.data);
  factory LoginRepo(LoginType loginType, dynamic data) {
    switch (loginType) {
      case LoginType.FB:
        return LoginRepo._internal('/auth/fb', data);
      case LoginType.Account:
        return LoginRepo._internal('/login', data);
      default:
        throw Exception('Not found the URL!');
    }
  }

  @override
  Future<ResponseModel> login() async {
    try {
      final response =
          await this._apiProviderImp.post(this.url, data: this.data);

      return SuccessModel(value: LoginWithEmailModel.fromJson(response.data));
    } catch (err) {
      return ErrorModel(value: err.response.data);
    }
  }
}
