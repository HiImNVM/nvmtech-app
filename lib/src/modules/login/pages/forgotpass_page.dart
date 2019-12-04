import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
 AppBloc _appBloc;
  @override
  Widget _renderForgotPassTitle() {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          BackButton(
            color: Colors.black,
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Text(
            CONST_FORGOTPASSTITLE,
            style: AppTextStyle.BLACK_W700_NORMAL_F30,
          )
        ],
      ),
    ]);
  }

  Widget _renderLogo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Image.asset(
        AppImage.PATH_MAIN_ICON,
        fit: BoxFit.cover,
        width: 80,
        height: 80,
      ),
    );
  }

  Widget _renderIntroduceText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
        CONST_FORGOTPASSTEXT,
        style: AppTextStyle.BROWNISHGREY_W600_NORMAL_F14,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _renderEmailForm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      child: TextField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: CONST_LOGINTEXT_ENTEREMAIL,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  void _onTapNavigation(String route){
    this._appBloc.getNavigator().pushReplacementNamed(route);
  }

  Widget _renderContinueButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: AppButton(
      color: AppColor.TOPAZ,
      child: Text(CONST_FORGOTPASS_CONTINUE),
      onPressed: () => _onTapNavigation('/verification'),
    ));
  }

  Widget _renderBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(children: <Widget>[
        _renderForgotPassTitle(),
        _renderLogo(),
        _renderIntroduceText(),
        _renderEmailForm(),
        _renderContinueButton(),
      ]),
    );
  }

  Widget build(BuildContext context) {
    this._appBloc = BlocProvider.of<AppBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _renderBody(),
    );
  }
}
