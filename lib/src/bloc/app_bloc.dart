import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/src/constants/sharedPreference_constant.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  GlobalKey<NavigatorState> _navigatorKey;

  //-------Theme (BehaviorSubject - Sink - Stream)
  final BehaviorSubject<ThemeType> _theme =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  void sinkThemeType(dynamic value) => this._theme.sink.add(value);
  ValueObservable<ThemeType> get streamThemeType => this._theme.stream;

  SharedPreferencesWrapper _sPreferencesWrapper;

  // -------Constructor-------
  AppBloc(navigatorKey) {
    this._navigatorKey = navigatorKey;
    SharedPreferencesWrapper.getInstance()
        .then((sf) => this._sPreferencesWrapper = sf);
  }

  NavigatorState getNavigator(){
    return this._navigatorKey.currentState;
  }
  void setupApp() async {
    bool isFirstTime = true;        // TODO: Hardcode
    isFirstTime = this._isFirstTime();

    if (isFirstTime) {
      this._navigatorKey.currentState.pushReplacementNamed('/login');
      return;
    }
    
    // bool isLoggined = false;
    bool isLoggined = this._isLoggined();
    if (!isLoggined) {
      this._navigatorKey.currentState.pushReplacementNamed('/login');
      return;
    }
  }

  bool _isLoggined() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_LOGGINED) ??
      false;

  bool _isFirstTime() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_FIRST_TIME) ??
      true;

  //-----Dispose----------
  @override
  void dispose() async {
    this._navigatorKey = null;
    this._sPreferencesWrapper = null;

    await this._theme?.drain();
    this._theme.close();
  }
}
