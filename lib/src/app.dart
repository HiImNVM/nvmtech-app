import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/app_bloc.dart';
import 'package:nvmtech/src/components/material/index_material.dart';
import 'package:nvmtech/src/modules/splash/pages/splash_page.dart';
import 'package:nvmtech/src/route.dart';
import 'package:nvmtech/src/styles/theme_style.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:nvmtech/src/util/print_util.dart';
import 'package:nvmtech/src/util/snapshot_util.dart';

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

    this._appBloc = AppBloc(MyApp.navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    printCountBuild('_MyAppState');
    return BlocProvider(
      bloc: this._appBloc,
      child: StreamBuilder<ThemeType>(
        stream: this._appBloc.streamThemeType,
        builder: (context, snapshot) {
          if (!hasDataSnapshotUtil(snapshot)) {
            return Container();
          }

          final routeGenerator = RouteGenerator();

          return AppMaterial(
            home: SplashPage(),
            onUnknownRoute: routeGenerator.generateNotFoundRoute,
            onGenerateRoute: routeGenerator.generateRoutes,
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
        throw Exception('Theme is not found!');
    }
  }
}
