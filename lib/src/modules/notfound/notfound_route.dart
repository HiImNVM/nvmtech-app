import 'package:flutter/material.dart';
import 'package:nvmtech/core/routes/index_routes.dart';

final RouteWrapper _routeWrapper = RouteWrapper();
final Map<String, Function> NOT_FOUND_ROUTE = {
  '/notfound': (RouteSettings settings) =>
      _routeWrapper.renderRoute(settings, null, RouteType.Error),
};
