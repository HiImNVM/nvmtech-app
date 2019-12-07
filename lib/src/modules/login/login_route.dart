import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/routes/index_routes.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/pages/codeverification_page.dart';
import 'package:nvmtech/src/modules/login/pages/login_page.dart';
import 'package:nvmtech/src/modules/login/pages/phoneverification_page.dart';

RouteWrapper _routeWrapper = RouteWrapper();
final Map<String, Function> LOGIN_ROUTE = {
  '/login': (RouteSettings settings) => _routeWrapper.renderRoute(
        settings,
        BlocProvider(
          bloc: LoginBloc(),
          child: LoginPage(),
        ),
      ),
  '/phoneverification': (RouteSettings settings) => _routeWrapper.renderRoute(
        settings,
        PhoneVerificationPage(),
      ),
  '/codeverification': (RouteSettings settings) => _routeWrapper.renderRoute(
    settings,
    CodeVerificationPage(),
  ),
};
