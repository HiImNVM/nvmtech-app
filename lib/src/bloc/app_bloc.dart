import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/core/widgets/toast/base_toast.dart';
import 'package:nvmtech/core/widgets/toast/toast_test.dart';
import 'package:nvmtech/src/constants/sharedPreference_constant.dart';
import 'package:nvmtech/src/modules/login/login_constant.dart';
import 'package:nvmtech/src/styles/color_style.dart';
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

  static void showToastMessage(BuildContext context, String title,
      [ToastType toastType = ToastType.Info]) {
    switch (toastType) {
      case ToastType.Success:
        {
          AchievementView(context,
              title: title,
              borderRadius: 0.5,
              color: AppColor.DARK_GREEN_SUCCESS_ICON_BG,
              alignment: Alignment.topCenter,
              subTitle: CONST_SUCCESS_SUBTITLE,
              textSubTitleColor: AppColor.MEDIUM_GREEN_SUCCESS_TEXT,
              icon:
                  Icon(Icons.check, color: AppColor.MEDIUM_GREEN_SUCCESS_TEXT),
               listener: (status) {
            print(status);
          })
            ..show();
          break;
        }
      case ToastType.Error:
        {
          AchievementView(context,
              title: title,
              borderRadius: 0.5,
              color: AppColor.DARK_RED_ERROR_ICON_BG,
              alignment: Alignment.topCenter,
              subTitle: CONST_ERROR_SUBTITLE,
              textSubTitleColor: AppColor.MEDIUM_RED_ERROR_TEXT,
              icon: Icon(Icons.clear, color: AppColor.MEDIUM_RED_ERROR_TEXT),
              listener: (status) {
            print(status);
          })
            ..show();
          break;
        }
      case ToastType.Info:
        {
          AchievementView(context,
              title: CONST_INFO_TITLE,
              borderRadius: 0.5,
              color: AppColor.DARK_GREY_INFO_ICON_BG,
              alignment: Alignment.topCenter,
              subTitle: CONST_ERROR_SUBTITLE,
              textSubTitleColor: AppColor.MEDIUM_GREY_INFO_TEXT,
              icon: Icon(Icons.access_time, color: Colors.white),
             listener: (status) {
            print(status);
          })
            ..show();
        }
        return;
    }
  }

  static void toastMessage(BuildContext context, String message,
      [ToastType toastType = ToastType.Info]) {
    Color toastColor;
    Color toastTextColor;
    Icon toastIcon;
    Color iconRectangleColor;

    switch (toastType) {
      case ToastType.Success:
        {
          toastColor = AppColor.LIGHT_GREEN_SUCCESS_BG;
          toastTextColor = AppColor.MEDIUM_GREEN_SUCCESS_TEXT;
          toastIcon = Icon(Icons.check, size: 30, color: toastTextColor);
          iconRectangleColor = AppColor.DARK_GREEN_SUCCESS_ICON_BG;
          break;
        }

      case ToastType.Error:
        {
          toastColor = AppColor.LIGHT_RED_ERROR_BG;
          toastTextColor = AppColor.MEDIUM_RED_ERROR_TEXT;
          toastIcon = Icon(Icons.clear, size: 20, color: toastTextColor);
          iconRectangleColor = AppColor.DARK_RED_ERROR_ICON_BG;
          break;
        }

      case ToastType.Info:
        {
          toastColor = AppColor.LIGHT_GREY_INFO_BG;
          toastTextColor = AppColor.MEDIUM_GREY_INFO_TEXT;
          toastIcon = Icon(Icons.access_time, size: 30, color: Colors.white);
          iconRectangleColor = AppColor.DARK_GREY_INFO_ICON_BG;
          break;
        }

      default:
        toastColor = Colors.white;
    }
    return Toast.show(message, context,
        backgroundColor: toastColor,
        textColor: toastTextColor,
        icon: toastIcon,
        iconRectangleColor: iconRectangleColor,
        gravity: Toast.TOP);
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
