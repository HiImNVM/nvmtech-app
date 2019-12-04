import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/routes/index_routes.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/pages/forgotpass_page.dart';
import 'package:nvmtech/src/modules/login/pages/login_page.dart';

RouteWrapper _routeWrapper = RouteWrapper();
final Map<String, Function> LOGIN_ROUTE = {
  '/login': (RouteSettings settings) => _routeWrapper.renderRoute(
        settings,
        BlocProvider(
          bloc: LoginBloc(),
          child: LoginPage(),
        ),
      ),
  '/forgotpassword': (RouteSettings settings) => _routeWrapper.renderRoute(
    settings,
      ForgotPasswordPage(),
    ),
};
