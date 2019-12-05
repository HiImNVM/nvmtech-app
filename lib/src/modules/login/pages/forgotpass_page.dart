import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/validationUtil.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  AppBloc _appBloc;
  @override
  Widget _renderBackButton() {
    return Row(
      children: <Widget>[
        BackButton(color: Colors.black),
      ],
    );
  }

  Widget _renderForgotPassTitle() {
    return Row(
      children: <Widget>[
        Text(CONST_FORGOTPASS_TITLE, 
          style: AppTextStyle.BLACK_W700_NORMAL_F30)
      ],
    );
  }

  Widget _renderLogo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      child: Image.asset(
        AppImage.PATH_MAIN_ICON,
        width: 80,
        height: 80,
      ),
    );
  }

  Widget _renderIntroduceText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
        CONST_FORGOTPASS_TEXT,
        style: AppTextStyle.BROWNISHGREY_W600_NORMAL_F14,
        textAlign: TextAlign.center,
      ),
    );
  }

  String _validateEmail(String value) {
    return Validation.validateEmail(value);
  }

  Widget _renderEmailForm() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: TextFormField(
          autovalidate: true,
          validator: _validateEmail,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: CONST_LOGINTEXT_ENTEREMAIL,
          ),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  void _onTapNavigation(String route) {
    this._appBloc.getNavigator().pushNamed(route);
  }

  Widget _renderContinueButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: AppButton(
          color: AppColor.TOPAZ,
          child: AppButton.renderTextInButton(
              CONST_FORGOTPASS_CONTINUE, AppTextStyle.WHITE_W700_NORMAL_F16),
          onPressed: () => _onTapNavigation('/phoneverification'),
        ));
  }

  Widget _renderBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(children: <Widget>[
        _renderBackButton(),
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
