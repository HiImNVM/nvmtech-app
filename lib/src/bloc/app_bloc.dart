import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/src/constants/sharedPreference_constant.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  final BehaviorSubject<AppStatus> _appStatus =
      BehaviorSubject<AppStatus>.seeded(AppStatus.Loading);

  void sinkAppStatus(dynamic value) => this._appStatus.sink.add(value);
  ValueObservable<AppStatus> get streamAppStatus => this._appStatus.stream;

  final BehaviorSubject<ThemeType> _theme =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  void sinkThemeType(dynamic value) => this._theme.sink.add(value);
  ValueObservable<ThemeType> get streamThemeType => this._theme.stream;

  SharedPreferencesWrapper _sPreferencesWrapper;

  AppBloc() {
    this._run();
  }

  void changeAppStatus(AppStatus newStatus) => this.sinkAppStatus(newStatus);

  void _run() async {
    this._sPreferencesWrapper = await SharedPreferencesWrapper.getInstance();

    final bool isFirstTime = this._isFirstTime();
    if (isFirstTime) {
      changeAppStatus(AppStatus.Welcome);
      return;
    }
  }

  bool _isFirstTime() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_FIRST_TIME) ??
      true;

  @override
  void dispose() async {
    this._sPreferencesWrapper = null;

    await this._appStatus?.drain();
    this._appStatus.close();

    await this._theme?.drain();
    this._theme.close();
  }
}
