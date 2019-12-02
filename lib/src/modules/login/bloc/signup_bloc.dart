import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/util/validationUtil.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BlocBase {
  final _nameSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

//static function
  static SignUpBloc of(BuildContext context) {
    return BlocProvider.of<SignUpBloc>(context);
  }

  //StreamTransformer => transform data day ra
  var nameValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    //email: validation
    //sink: add string data to UI
    sink.add(Validation.validateName(name));
  });
  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    //email: validation
    //sink: add string data to UI
    sink.add(Validation.validateEmail(email));
  });
  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add((Validation.validatePassword(pass)));
  });

  //Stream(output) -Sink(input)
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

  Sink<bool> get btnSink => _btnSubject.sink;
  Stream<bool> get btnStream => _btnSubject.stream;

  //Constructor
  SignUpBloc() {
//Observable.combineLatest2 hợp nhất nhiều Stream(subject = sink + stream) thành một Stream

    Observable.combineLatest3(_nameSubject, _emailSubject, _passwordSubject,
        (name, email, pass) {
      Validation.validateName(name) == null &&
          Validation.validateEmail(email) == null &&
          Validation.validatePassword(pass) == null;
    }).listen((enable) {
      //Lang nghe viec co bi thay doi hay ko?
      btnSink.add(enable);
      //sink add thay doi den BloC(business logic)
      //BLoC notify thay đổi đến Widget thông qua stream
    });
  }

  @override
  void dispose() async {
    _nameSubject.close();
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }
}
