import 'package:flutter/material.dart';

class AppMaterial extends StatelessWidget {
  AppMaterial({
    this.home,
    this.onGenerateRoute,
    this.theme,
    this.navigatorKey,
    this.navigatorObservers,
    this.onUnknownRoute,
    this.initialRoute,
  });

  final Widget home;
  final RouteFactory onGenerateRoute;
  final ThemeData theme;
  final GlobalKey<NavigatorState> navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final RouteFactory onUnknownRoute;
  final String initialRoute;

  Widget _renderBuilderWithNewMediaQueryData(
      BuildContext context, Widget child) {
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(data: data.copyWith(textScaleFactor: 1), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: this.initialRoute,
      home: this.home,
      onGenerateRoute: this.onGenerateRoute,
      onUnknownRoute: this.onUnknownRoute,
      builder: this._renderBuilderWithNewMediaQueryData,
      navigatorKey: this.navigatorKey,
      navigatorObservers: this.navigatorObservers,
    );
  }
}
