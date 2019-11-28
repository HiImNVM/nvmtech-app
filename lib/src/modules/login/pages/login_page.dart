import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/widgets/loading/index_loading.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/components/modal/success_modal.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:nvmtech/src/util/printUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  
  Widget _renderTextInButton(String text) {
    return Text(
      text,
      style: AppTextStyle.WHITE_W700_NORMAL_F16,
    );
  }

  Widget _renderBody(loginState, context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 24),
                margin: EdgeInsets.only(top: 82),
                child: Text(
                  loginText_signintitle,
                  style: AppTextStyle.BLACK_W700_NORMAL_F30,
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 32),
              child: Image.asset(
                AppImage.PATH_MAIN_ICON,
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              )),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: AppButton(
              color: AppColor.TOPAZ,
              onPressed: () {},
              child: _renderTextInButton(loginText_signintitle),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 24)),
              Text("Don't" + loginText_signin,
                  style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
//              GestureDetector(),
              Text(loginText_signuptitle,
                  style: AppTextStyle.BLACK_W600_NORMAL_F12),
            ],
          ),
          Text(
            loginText_or,
            style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              children: <Widget>[
                AppButton(
                    color: AppColor.DARKBLUEFACEBOOK,
                    onPressed: () {},
                    child: _renderTextInButton('Login with Facebook')),
                SizedBox(
                  height: 10,
                ),
                AppButton(
                  color: AppColor.REDGOOGLE,
                  onPressed: () =>
                      this._loginBloc.sinkLoginType(LoginState.Success),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 0,
                          child: Image.asset(
                            AppImage.PATH_GOOGLE_ICON,
                            fit: BoxFit.fill,
                          )),
                      Expanded(flex: 1, child: Text(' |')),
                      Expanded(
                        flex: 3,
                        child: _renderTextInButton('Login with Google'),
                      ),
                    ],
                  ),
                ),
              ],
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
