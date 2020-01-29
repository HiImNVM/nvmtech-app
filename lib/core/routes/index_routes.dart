import 'package:flutter/material.dart';
import 'package:nvmtech/core/widgets/fadedTransition/index_fadedTransition.dart';

enum RouteType {
  Error,
  Basic,
  Fade,
  Dialog,
}

class RouteWrapper {
  static RouteWrapper _instance = RouteWrapper._internal();
  RouteWrapper._internal();
  factory RouteWrapper() => _instance;

  Route renderRoute(RouteSettings settings, Widget builder,
      [RouteType routeType = RouteType.Basic]) {
    switch (routeType) {
      case RouteType.Error:
        return this._routeError(settings, builder);
      case RouteType.Fade:
        return this._routeFade(settings, builder);
      case RouteType.Dialog:
        return this._routeDialog(settings, builder);
      default:
        return this._route(settings, builder);
    }
  }

  PageRouteBuilder _routeError(RouteSettings settings, Widget builder) {
    return FadedTransitionRoute(
      settings: settings,
      widget: builder ??
          Scaffold(
            appBar: AppBar(
              title: Text('Coming soon'),
            ),
            body: Center(
              child: Text('Page not found'),
            ),
          ),
    );
  }

  MaterialPageRoute _route(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }

  PageRouteBuilder _routeFade(RouteSettings settings, Widget builder) {
    return FadedTransitionRoute(
      settings: settings,
      widget: builder,
    );
  }

  MaterialPageRoute _routeDialog(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      fullscreenDialog: true,
      builder: (BuildContext context) => builder,
    );
  }
}
