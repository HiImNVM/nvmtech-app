import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/src/components/toast/index.dart';
import 'package:nvmtech/src/constants/sharedPreference_constant.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  GlobalKey<NavigatorState> _navigatorKey;
  static SharedPreferencesWrapper sPreferencesWrapper;

  final BehaviorSubject<ThemeType> _theme =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  void _sinkThemeType(ThemeType value) => this._theme.sink.add(value);
  Stream<ThemeType> get streamThemeType => this._theme.stream;

  final _AppEventBloc _appEventBloc = _AppEventBloc();
  _AppEventBloc get getEventBloc => this._appEventBloc;

  AppBloc(navigatorKey) {
    this._navigatorKey = navigatorKey;
    SharedPreferencesWrapper.getInstance()
        .then((sf) => sPreferencesWrapper = sf);
  }

  NavigatorState getNavigator() => this._navigatorKey.currentState;

  void logout() {}
  void changeTheme([bool isLight = true]) =>
      this._sinkThemeType(isLight ? ThemeType.Light : ThemeType.Dark);

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

  static void showToastMessage(BuildContext context, String message,
      [ToastType toastType = ToastType.Info]) {
    switch (toastType) {
      case ToastType.Success:
        {
          showToastSuccess(context, message);
          break;
        }
      case ToastType.Error:
        {
          showToastError(context, message);
          break;
        }
      case ToastType.Info:
        {
          showToastInfo(context, message);
        }
        return;
    }
  }

  static void setUserInfoToStore(
      String userId, String token, String refreshToken) {
    sPreferencesWrapper.getSPreferences().setString(CONST_USER_ID, userId);
    sPreferencesWrapper.getSPreferences().setString(CONST_USER_TOKEN, token);
    sPreferencesWrapper
        .getSPreferences()
        .setString(CONST_USER_REFRESHTOKEN, refreshToken);
  }

  bool _isLoggined() =>
      sPreferencesWrapper.getSPreferences().getBool(CONST_LOGGINED) ?? false;

  bool _isFirstTime() =>
      sPreferencesWrapper.getSPreferences().getBool(CONST_FIRST_TIME) ?? true;

  @override
  void dispose() async {
    this._navigatorKey = null;
    sPreferencesWrapper = null;

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
