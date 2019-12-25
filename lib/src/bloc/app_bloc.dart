import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/core/widgets/toast/base_toast.dart';
import 'package:nvmtech/src/constants/sharedPreference_constant.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  GlobalKey<NavigatorState> _navigatorKey;

  final BehaviorSubject<ThemeType> _theme =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  void sinkThemeType(dynamic value) => this._theme.sink.add(value);
  ValueObservable<ThemeType> get streamThemeType => this._theme.stream;

  final _AppEventBloc _appEventBloc = _AppEventBloc();
  _AppEventBloc get getEventBloc => this._appEventBloc;

  SharedPreferencesWrapper _sPreferencesWrapper;

  AppBloc(navigatorKey) {
    this._navigatorKey = navigatorKey;
    SharedPreferencesWrapper.getInstance()
        .then((sf) => this._sPreferencesWrapper = sf);
  }

  NavigatorState getNavigator() {
    return this._navigatorKey.currentState;
  }

  void setupApp() async {
    final bool isFirstTime = this._isFirstTime();

    if (isFirstTime) {
      this._navigatorKey.currentState.pushReplacementNamed('/welcome');
      return;
    }

    bool isLoggined = this._isLoggined();
    if (!isLoggined) {
      this._navigatorKey.currentState.pushReplacementNamed('/login');
      return;
    }
  }

  static void toastMessage(BuildContext context, String message,
      [ToastType toastType = ToastType.Info]) {
    Color toastColor;
    switch (toastType) {
      case ToastType.Success:
        {
          toastColor = Colors.green;
          break;
        }
      case ToastType.Error:
        {
          toastColor = Colors.red;
          break;
        }
        break;
      default:
        toastColor = Colors.white;
    }
    return Toast.show(message, context, backgroundColor: toastColor);
  }

  bool _isLoggined() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_LOGGINED) ??
      false;

  bool _isFirstTime() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_FIRST_TIME) ??
      true;

  @override
  void dispose() async {
    this._navigatorKey = null;
    this._sPreferencesWrapper = null;

    await this._theme?.drain();
    this._theme.close();
  }
}

class _AppEventBloc extends BlocBase {
  static final _instance = _AppEventBloc._internal();

  factory _AppEventBloc() => _instance;

  _AppEventBloc._internal();

  final PublishSubject<BlocEvent> _appEventController =
      PublishSubject<BlocEvent>();
  Function(BlocEvent) get emitAppEvent => this._appEventController.sink.add;

  StreamSubscription<BlocEvent> listenEvent(
    dynamic evtName,
    Function(BlocEvent) hdl,
  ) =>
      this
          ._appEventController
          .stream
          .where((evt) => evt.eventName == evtName)
          .listen(hdl);

  StreamSubscription<BlocEvent> listenManyEvents(
    List evtNames,
    Function(BlocEvent) hdl,
  ) =>
      this
          ._appEventController
          .stream
          .where((evt) => evtNames.contains(evt.eventName))
          .listen(hdl);

  @override
  void dispose() {
    this._appEventController?.close();
  }
}
