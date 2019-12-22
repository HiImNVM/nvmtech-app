import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/modules/login/login_constant.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:nvmtech/src/util/validationUtil.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  final BehaviorSubject<LoginState> _loginState =
      BehaviorSubject<LoginState>.seeded(LoginState.Default);
  ValueObservable<LoginState> get getStreamLoginType => this._loginState.stream;
  void sinkLoginType(LoginState newLoginType) =>
      this._loginState.sink.add(newLoginType);

  final BehaviorSubject<String> _emailSubject = 
      BehaviorSubject<String>.seeded('');
  ValueObservable<String> get getStreamEmail => this._emailSubject.stream;
  void _sinkErrorMessageEmail(String errorMessage) =>
      this._emailSubject.sink.add(errorMessage);

  final BehaviorSubject<String> _passwordSubject =
      BehaviorSubject<String>.seeded('');
  ValueObservable<String> get getStreamPassword => this._passwordSubject.stream;
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

  void loginWithEmail(context, String email, String password) {
    this.sinkLoginType(LoginState.Loading);
    // TODO: Set delayed to test, should handle with API
    Future.delayed(Duration(seconds: 1), () {
      this.sinkLoginType(LoginState.Default);

      if (Validation.validateEmail(email).isNotEmpty ||
          Validation.validatePassword(password).isNotEmpty) {
        AppBloc.toastMessage(
            context, CONST_LOGIN_FAIL_INVALID_INPUT, ToastType.Error);
        return;
      }

      AppBloc.toastMessage(context, 'Login success', ToastType.Success);
    });
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
