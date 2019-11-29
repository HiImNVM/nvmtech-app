import 'package:flutter/material.dart';
import 'package:nvmtech/core/routes/index_routes.dart';
import 'package:nvmtech/src/modules/welcome/pages/welcome_page.dart';

RouteWrapper _routeWrapper = RouteWrapper();
final Map<String, Function> WELCOME_ROUTE = {
  '/welcome': (RouteSettings settings) => _routeWrapper.renderRoute(
        settings,
        WelcomePage(),
      ),
};
