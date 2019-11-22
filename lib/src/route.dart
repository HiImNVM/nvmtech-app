import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/routes/index_routes.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/pages/login_page.dart';

class RouteGenerator {
  static RouteGenerator _instance = RouteGenerator._internal();
  RouteGenerator._internal();
  factory RouteGenerator() => _instance;
  static RouteWrapper _routeWrapper = RouteWrapper();

  final Map<String, Function> _routesUnAuthen = {
    // Default
    '/': (RouteSettings settings) => _routeWrapper.renderRoute(
          settings,
          BlocProvider(
            bloc: LoginBloc(),
            child: LoginPage(),
          ),
        ),
  };

  final Map<String, Function> _routesAuthen = {
    // Default
    '/': null,
  };

  Route getRoute(RouteSettings settings, [bool isAuthen = true]) => isAuthen
      ? _routesAuthen[settings.name](settings)
      : _routesUnAuthen[settings.name](settings);
}
