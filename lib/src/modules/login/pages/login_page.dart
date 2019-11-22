import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/widgets/loading/index_loading.dart';
import 'package:nvmtech/src/components/button/button.dart';
import 'package:nvmtech/src/components/modal/prompt_modal.dart';
import 'package:nvmtech/src/components/modal/success_modal.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:nvmtech/src/util/printUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  Widget _renderBody(loginState, context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('Login'),
          AppButton(
            onPressed: () => this._loginBloc.sinkLoginType(LoginState.Success),
            child: Text(
              'Login with Facebook',
              style: AppTextStyle.WHITE_W700_NORMAL_F16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderPopup(LoginState loginState) {
    switch (loginState) {
      case LoginState.Loading:
        return LoadingWidget();
      case LoginState.Success:
        return SuccessModal(
          content: 'Login success!',
          onOk: () => this._loginBloc.navigateToDashBoard(context),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    this._loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ABC'),
      ),
      body: StreamBuilder<LoginState>(
        stream: this._loginBloc.getStreamLoginType,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            printError(snapshot.error);
            return Container();
          }

          if (!snapshot.hasData) return Container();

          return Stack(
            children: <Widget>[
              this._renderBody(snapshot.data, context),
              this._renderPopup(snapshot.data),
            ],
          );
        },
      ),
    );
  }
}
