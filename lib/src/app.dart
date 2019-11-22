import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/route.dart';
import 'package:nvmtech/src/styles/theme_style.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:nvmtech/src/util/printUtil.dart';

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();

    this._appBloc = AppBloc();
  }

  // TODO: Should create splash screen instead of Container
  Widget _renderAppLoading(ThemeType themeType) => Container(
        color: this._getTheme(themeType).primaryColor,
      );

  Widget _renderBuilderWithNewMediaQueryData(
      BuildContext context, Widget child) {
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(data: data.copyWith(textScaleFactor: 1), child: child);
  }

  Widget _renderTheme(AppStatus appStatus) => StreamBuilder<ThemeType>(
        stream: this._appBloc.streamThemeType,
        builder: (BuildContext context, AsyncSnapshot<ThemeType> snapshot) {
          if (snapshot.hasError) {
            printError(snapshot.error);
            return Container();
          }

          if (!snapshot.hasData) return Container();

          return MaterialApp(
            key: ValueKey(appStatus.toString()),
            initialRoute: '/',
            onGenerateRoute: (RouteSettings routeSettings) =>
                this._generaterRoutes(appStatus, routeSettings),
            theme: this._getTheme(snapshot.data),
            navigatorKey: MyApp.navigatorKey,
            navigatorObservers: [], // TODO: Should update with firebase early
            builder: this._renderBuilderWithNewMediaQueryData,
          );
        },
      );

  @override
  Widget build(BuildContext context) => BlocProvider(
        bloc: this._appBloc,
        child: StreamBuilder<AppStatus>(
          stream: this._appBloc.streamAppStatus,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              printError(snapshot.error);
              return Container();
            }

            if (!snapshot.hasData) return Container();

            if (snapshot.data == AppStatus.Loading)
              return this
                  ._renderAppLoading(this._appBloc.streamThemeType.value);

            return this._renderTheme(snapshot.data);
          },
        ),
      );

  ThemeData _getTheme(ThemeType themeType) {
    // TODO: Should update anorther themes
    switch (themeType) {
      case ThemeType.Light:
        return AppTheme.LIGHT_THEME;
      default:
        return AppTheme.LIGHT_THEME;
    }
  }

  Route _generaterRoutes(AppStatus appStatus, RouteSettings routeSettings) =>
      RouteGenerator().getRoute(routeSettings, appStatus == AppStatus.Auth);
}
