import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/material/index_material.dart';
import 'package:nvmtech/src/modules/splash/pages/splash_page.dart';
import 'package:nvmtech/src/route.dart';
import 'package:nvmtech/src/styles/theme_style.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:nvmtech/src/util/printUtil.dart';

class MyApp extends StatefulWidget {
  //Navigate without context
  //Navigate from business logic, where the context is not available
  // GlobalKey(Stateful) access the NavigatorState outside of the build context
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();

    this._appBloc = AppBloc(MyApp.navigatorKey);
  }

  Route _renderUnknowRoute(RouteSettings routeSettings) {
    // TODO: Should early update
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: this._appBloc,
      child: StreamBuilder<ThemeType>(
        stream: this._appBloc.streamThemeType,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            printError(snapshot.error);
            return Container();
          }

          if (!snapshot.hasData) return Container();

          return AppMaterial(
            home: SplashPage(),
            onUnknownRoute: this._renderUnknowRoute,
            onGenerateRoute: RouteGenerator().generateRoutes,
            theme: this._getTheme(snapshot.data),
            navigatorKey: MyApp.navigatorKey,
            navigatorObservers: [], // TODO: Should update with firebase early
          );
        },
      ),
    );
  }

  ThemeData _getTheme(ThemeType themeType) {
    // TODO: Should update another themes
    switch (themeType) {
      case ThemeType.Light:
        return AppTheme.LIGHT_THEME;
      default:
        return AppTheme.LIGHT_THEME;
    }
  }
}