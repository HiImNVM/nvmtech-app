import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:nvmtech/config.dart';
import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/common/fb_login.dart';
import 'package:nvmtech/src/app_bloc.dart';
import 'package:nvmtech/src/models/response_error_model.dart';
import 'package:nvmtech/src/modules/login/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/models/loginWithEmail_model.dart';
import 'package:nvmtech/src/modules/login/repositories/login_repo.dart';
import 'package:nvmtech/src/modules/login/types/login_type.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/util/print_util.dart';
import 'package:nvmtech/src/util/validation_util.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  final _loginState = BehaviorSubject<LoginState>.seeded(LoginState.Default);
  Stream<LoginState> get getStreamLoginType => this._loginState.stream;
  void sinkLoginType(LoginState newLoginType) =>
      this._loginState.sink.add(newLoginType);

  final _emailSubject = BehaviorSubject<String>.seeded('');
  Stream<String> get getStreamEmail => this._emailSubject.stream;
  void _sinkErrorMessageEmail(String errorMessage) =>
      this._emailSubject.sink.add(errorMessage);

  final _passwordSubject = BehaviorSubject<String>.seeded('');
  Stream<String> get getStreamPassword => this._passwordSubject.stream;
  void _sinkErrorMessagePassword(String errorMessage) =>
      this._passwordSubject.sink.add(errorMessage);

  void validateEmail(String email) {
    final String error = Validation.validateEmail(email);
    if (error == null || error.isEmpty) {
      this._sinkErrorMessageEmail('');
      return;
    }

    this._sinkErrorMessageEmail(error);
  }

  void validatePassword(String password) {
    final String error = Validation.validatePassword(password);
    if (error == null || error.isEmpty) {
      this._sinkErrorMessagePassword('');
      return;
    }

    this._sinkErrorMessagePassword(error);
  }

  void loginWithEmail(context, String email, String password) async {
    if (Validation.validateEmail(email).isNotEmpty ||
        Validation.validatePassword(password).isNotEmpty) {
      AppBloc.showToastMessage(context, CONST_ERROR_SUBTITLE, ToastType.Error);
      return;
    }

    this.sinkLoginType(LoginState.Loading);

    final ResponseModel responseModel = await LoginRepo(LoginType.Account, {
      "email": email,
      "password": password,
    }).login();

    this.sinkLoginType(LoginState.Default);

    if (responseModel is SuccessModel) {
      printInfo('Login success!');
      final loginWithEmailModel = (responseModel.value as LoginWithEmailModel);

      if (loginWithEmailModel == null || loginWithEmailModel.id == null) {
        AppBloc.showToastMessage(context, CONST_LOGIN_FAIL, ToastType.Error);
        return;
      }

      AppBloc.setUserInfoToStore(loginWithEmailModel.id.toString(),
          loginWithEmailModel.token, loginWithEmailModel.refreshToken);

      // TODO: Should replace show toast successful to navigate home page
      AppBloc.showToastMessage(
          context, CONST_SUCCESS_SUBTITLE, ToastType.Success);
      return;
    }

    printInfo('Login fail!');
    AppBloc.showToastMessage(
        context,
        ((responseModel as ErrorModel).value as ResponseError).message,
        ToastType.Error);
  }

  Future<bool> loginWithFb(context) async {
    final fbLoginService = FBLoginImp(AppConfig.FB_PERS_NAME);
    final status = await fbLoginService.loginWithFB();

    if (status == FacebookLoginStatus.error) {
      AppBloc.showToastMessage(
          context, CONST_ERROR_LOGIN_FAIL_WITH_FACEBOOK, ToastType.Error);
      return false;
    }

    if (status == FacebookLoginStatus.cancelledByUser) {
      AppBloc.showToastMessage(context, CONST_CANCEL_LOGIN_WITH_FACEBOOK);
      return false;
    }

    final token = fbLoginService.getToken;

    if (token == null || token.isEmpty) {
      AppBloc.showToastMessage(
          context, CONST_EMPTY_FACEBOOK_TOKEN, ToastType.Error);
      return false;
    }

    printInfo('FB token: $token');

    // Async save token to store
    AppBloc.sPreferencesWrapper.setToken(token);
    return true;
  }

  @override
  void dispose() async {
    await this._loginState?.drain();
    this._loginState.close();

    await this._emailSubject?.drain();
    this._emailSubject.close();

    await this._passwordSubject?.drain();
    this._passwordSubject.close();
  }
}
