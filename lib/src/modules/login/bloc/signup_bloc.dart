import 'dart:async';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/src/util/validationUtil.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BlocBase {
  final _nameSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _isLoginSuccessSubject = BehaviorSubject<bool>();

  final nameValidation =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    sink.add(Validation.validateName(name));
  });
  final emailValidation =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validateEmail(email));
  });
  final passValidation =
  StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add((Validation.validatePassword(pass)));
  });

  //skip(1) = khi focus vao ko bao message error
  Sink<String> get nameSink => _nameSubject.sink;
  Stream<String> get nameStream =>
    _nameSubject.stream.transform(nameValidation).skip(1);

  Sink<String> get emailSink => _emailSubject.sink;
  Stream<String> get emailStream =>
    _emailSubject.stream.transform(emailValidation).skip(1);

  Sink<String> get passwordSink => _passwordSubject.sink;
  Stream<String> get passwordStream =>
    _passwordSubject.stream.transform(passValidation).skip(1);

  Sink<bool> get isLoginSuccessSink => _isLoginSuccessSubject.sink;
  Stream<bool> get isLoginSuccessStream => _isLoginSuccessSubject.stream;
  
  SignUpBloc() {
    Observable.combineLatest3(_nameSubject, _emailSubject, _passwordSubject,
        (name, email, pass) {
        Validation.validateName(name) == null &&
          Validation.validateEmail(email) == null &&
          Validation.validatePassword(pass) == null;
      }).listen((enable) {
      isLoginSuccessSink.add(enable);
    });
  }

  @override
  void dispose() async {
    await this._nameSubject?.drain();
    _nameSubject.close();
    
    await this._emailSubject?.drain();
    _emailSubject.close();
    
    await this._passwordSubject?.drain();
    _passwordSubject.close();

    await this._isLoginSuccessSubject?.drain();
    _isLoginSuccessSubject.close();
  }
}