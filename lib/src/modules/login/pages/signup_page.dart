import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/bloc/signup_bloc.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/snapshotUtil.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpBloc _signUpBloc;
  AppBloc _appBloc;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      _signUpBloc.nameSink.add(_nameController.text);
    });

    _emailController.addListener(() {
      _signUpBloc.emailSink.add(_emailController.text);
    });

    _passwordController.addListener(() {
      _signUpBloc.passwordSink.add(_passwordController.text);
    });
  }

  Widget _renderSignUpTitle() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 24),
          margin: EdgeInsets.only(top: 82),
          child: Text(
            CONST_LOGINTEXT_SIGNUPTITLE,
            style: AppTextStyle.BLACK_W700_NORMAL_F30,
          ),
        )
      ],
    );
  }

  Widget _renderLogo() {
    return Container(
        margin: EdgeInsets.only(top: 32),
        child: Image.asset(
          AppImage.PATH_MAIN_ICON,
          width: 80,
          height: 80,
          fit: BoxFit.fill,
        ));
  }

  Widget _renderNameEmailPassForm() {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          StreamBuilder<String>(
              stream: _signUpBloc.nameStream,
              builder: (context, snapshot) {
                if (!hasDataSnapshotUtil(snapshot)) {
                  return Container();
                }
                return TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    errorText: snapshot.data,
                  ),
                  keyboardType: TextInputType.text,
                );
              }),
          StreamBuilder<String>(
              stream: _signUpBloc.emailStream,
              builder: (context, snapshot) {
                if (!hasDataSnapshotUtil(snapshot)) {
                  return Container();
                }
                return TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    errorText: snapshot.data,
                  ),
                  keyboardType: TextInputType.emailAddress,
                );
              }),
          StreamBuilder<String>(
              stream: _signUpBloc.passwordStream,
              builder: (context, snapshot) {
                if (!hasDataSnapshotUtil(snapshot)) {
                  return Container();
                }
                return TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    errorText: snapshot.data,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                );
              }),
        ]));
  }

  Widget _renderSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: StreamBuilder<bool>(
          stream: _signUpBloc.isLoginSuccessStream,
          builder: (context, snapshot) {
            if (!hasDataSnapshotUtil(snapshot)) {
              return Container();
            }
            return AppButton(
              color: AppColor.TOPAZ,
              child: AppButton.renderTextInButton(CONST_LOGINTEXT_SIGNUPTITLE),
              onPressed: () => _onTapSignInNavigation('/login'),
            );
          }),
    );
  }

  void _onTapSignInNavigation(String route) {
    this._appBloc.getNavigator().pushReplacementNamed(route);
  }

  Widget _renderNavigateToSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 24)),
        Text("Already" + CONST_LOGINTEXT_SIGNIN,
            style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
        GestureDetector(
            onTap: () => _onTapSignInNavigation('/login'),
            child: Text(CONST_LOGINTEXT_SIGNINTITLE,
                style: AppTextStyle.BLACK_W600_NORMAL_F12)),
      ],
    );
  }

  Widget _renderDecorationInsideSocialMedia(String appimglogo, String text) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 0,
            child: Image.asset(
              appimglogo,
              fit: BoxFit.fill,
            )),
        Expanded(flex: 1, child: Text(' |')),
        Expanded(
          flex: 3,
          child: AppButton.renderTextInButton(text),
        ),
      ],
    );
  }

  Widget _renderSocialMediaButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: <Widget>[
          AppButton(
            color: AppColor.DARKBLUEFACEBOOK,
            onPressed: () {},
            child: _renderDecorationInsideSocialMedia(
                AppImage.PATH_FACEBOOK_ICON, CONST_LOGINTEXT_FACEBOOK),
          ),
          SizedBox(
            height: 10,
          ),
          AppButton(
              color: AppColor.REDGOOGLE,
              onPressed: () {},
              child: _renderDecorationInsideSocialMedia(
                  AppImage.PATH_GOOGLE_ICON, CONST_LOGINTEXT_GOOGLE)),
        ],
      ),
    );
  }

  Widget _renderBody() {
    return Center(
      child: Column(
        children: <Widget>[
          _renderSignUpTitle(),
          _renderLogo(),
          _renderNameEmailPassForm(),
          _renderSignUpButton(),
          _renderNavigateToSignUp(),
          Text(CONST_LOGINTEXT_OR,
              style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
          _renderSocialMediaButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this._appBloc = BlocProvider.of<AppBloc>(context);
    this._signUpBloc = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      body: _renderBody(),
    );
  }
}
