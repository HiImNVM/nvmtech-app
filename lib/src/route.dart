import 'package:flutter/material.dart';
import 'package:nvmtech/src/modules/login/login_route.dart';
import 'package:nvmtech/src/modules/notfound/notfound_route.dart';
import 'package:nvmtech/src/modules/welcome/welcome_route.dart';

class RouteGenerator {
  static RouteGenerator _instance = RouteGenerator._internal();
  RouteGenerator._internal();
  factory RouteGenerator() => _instance;

  Map<String, Function> _routes = {
    ...LOGIN_ROUTE,
    ...WELCOME_ROUTE,
    ...NOT_FOUND_ROUTE,
  };

  Route generateRoutes(RouteSettings routeSettings) {
    final existFunc = this._routes[routeSettings.name];

    return existFunc == null ? null : existFunc(routeSettings);
  }

  Route generateNotFoundRoute(RouteSettings routeSettings) =>
      this._routes['/notfound'](routeSettings);
}
