import 'dart:async';

import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:nvmtech/src/util/validationUtil.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  BehaviorSubject<LoginState> _loginType =
      BehaviorSubject<LoginState>.seeded(LoginState.Default);

  ValueObservable<LoginState> get getStreamLoginType => this._loginType.stream;
  void sinkLoginType(LoginState newLoginType) =>
      this._loginType.sink.add(newLoginType);

  void navigateToDashBoard(context) {
    final AppBloc appBloc = BlocProvider.of(context);
  }

  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _isLoginSuccessSubject = BehaviorSubject<bool>();

  //StreamTransformer => transform data day ra
  var emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      //email: validation
      //sink: add string data to UI
      sink.add(Validation.validateEmail(email));
    }
  );
  var passValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink){
      sink.add((Validation.validatePassword(pass)));
    }
  );

  //Stream(output) -Sink(input)
  //skip(1) = khi focus vao ko bao message error
  Sink<String> get emailSink => _emailSubject.sink;
  Stream<String> get emailStream => _emailSubject.stream.transform(emailValidation).skip(1);

  Sink<String> get passwordSink => _passwordSubject.sink;
  Stream<String> get passwordStream => _passwordSubject.stream.transform(passValidation).skip(1);

  Sink<bool> get isLoginSuccessSink => _isLoginSuccessSubject.sink;
  Stream<bool> get isLoginSuccessStream => _isLoginSuccessSubject.stream;

  //Constructor
  LoginBloc() {
//Observable.combineLatest2 hợp nhất nhiều Stream(subject = sink + stream) thành một Stream
    Observable.combineLatest2(_emailSubject, _passwordSubject, (email, pass) {
      return Validation.validateEmail(email) == null &&
        Validation.validatePassword(pass) == null;
    }).listen((enable) { //Lang nghe viec co bi thay doi hay ko?
      isLoginSuccessSink.add(enable);
      //sink add thay doi den BloC(business logic)
      //BLoC notify thay đổi đến Widget thông qua stream
    });
  }

  @override
  void dispose() async {
    await this._loginType?.drain();
    this._loginType.close();

    await this._emailSubject?.drain();
    this._emailSubject.close();

    await this._passwordSubject?.drain();
    this._passwordSubject.close();

    await this._isLoginSuccessSubject?.drain();
    this._isLoginSuccessSubject.close();
  }
}
