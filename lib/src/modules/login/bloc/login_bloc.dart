import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  BehaviorSubject<LoginState> _loginType =
      BehaviorSubject<LoginState>.seeded(LoginState.Default);

  ValueObservable<LoginState> get getStreamLoginType => this._loginType.stream;
  void sinkLoginType(LoginState newLoginType) =>
      this._loginType.sink.add(newLoginType);

  void navigateToDashBoard(context) {
    final AppBloc appBloc = BlocProvider.of(context);
    appBloc.changeAppStatus(AppStatus.Loading);
  }

  @override
  void dispose() async {
    await this._loginType?.drain();
    this._loginType.close();
  }
}
