import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/routes/index_routes.dart';
import 'package:nvmtech/src/modules/login/bloc/forgotpassword_bloc.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/bloc/verificationCode_bloc.dart';
import 'package:nvmtech/src/modules/login/pages/forgotpassword_page.dart';
import 'package:nvmtech/src/modules/login/pages/login_page.dart';
import 'package:nvmtech/src/modules/login/pages/verificationCode_page.dart';
import 'package:nvmtech/src/params.dart';

final RouteWrapper _routeWrapper = RouteWrapper();
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
        BlocProvider(
          bloc: ForgotPasswordBloc(),
          child: ForgotPasswordPage(),
        ),
      ),
  '/verificationCode': (RouteSettings settings) => _routeWrapper.renderRoute(
        settings,
        BlocProvider(
          bloc: VerificationCodeBloc(
              (settings.arguments as VerificationCodePageArgument)
                  .countDownCode),
          child: VerificationCodePage(settings.arguments),
        ),
      ),
};
