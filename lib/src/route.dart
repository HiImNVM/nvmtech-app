import 'package:flutter/material.dart';
import 'package:nvmtech/src/modules/login/login_route.dart';
import 'package:nvmtech/src/modules/welcome/welcome_route.dart';

class RouteGenerator {
  static RouteGenerator _instance = RouteGenerator._internal();
  RouteGenerator._internal();
  factory RouteGenerator() => _instance;

  Route generateRoutes(RouteSettings routeSettings) =>
      this._routes[routeSettings.name](routeSettings);

  Map<String, Function> _routes = {
    ...LOGIN_ROUTE,
    ...WELCOME_ROUTE,
  };
}
