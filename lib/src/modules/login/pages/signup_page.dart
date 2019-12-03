import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/bloc/signup_bloc.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/printUtil.dart';
import 'package:nvmtech/src/util/snapshotUtil.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpBloc _signUpBloc;
  AppBloc _appBloc;

  //Khai bao controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //listen textchange tu textform(user interaction) roi add vao stream(output)
    nameController.addListener(() {
      SignUpBloc.of(context).nameSink.add(nameController.text);
    });

    emailController.addListener(() {
      SignUpBloc.of(context).emailSink.add(emailController.text);
    });

    passwordController.addListener(() {
      SignUpBloc.of(context).passwordSink.add(passwordController.text);
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
                return TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    errorText: snapshot.data,
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "NunitoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                );
              }),
          StreamBuilder<String>(
              stream: _signUpBloc.emailStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    errorText: snapshot.data,
                  ),
                  keyboardType: TextInputType.emailAddress, // @
                );
              }),
          StreamBuilder<String>(
              stream: _signUpBloc.passwordStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    errorText: snapshot.data,
                  ),
                  keyboardType: TextInputType.visiblePassword, // @
                );
              }),
//          SizedBox(height: 10,),
//          _renderForgotPassword(),
        ]));
  }
//
//  Widget _renderForgotPassword() {
//    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
//      GestureDetector(
//        onTap: () => _onTapSignInNavigation('/login'),
//        child: Text(CONST_FORGOTPASSTITLE + "?",
//          style: AppTextStyle.LIGHTGREY_W600_NORMAL_F12)),
//    ]);
//  }

  Widget _renderTextInButton(String text) {
    return Text(
      text,
      style: AppTextStyle.WHITE_W700_NORMAL_F16,
    );
  }

  Widget _renderSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: StreamBuilder<bool>(
          stream: _signUpBloc.isLoginSuccessStream,
          builder: (context, snapshot) {
            if (snapshotUtil(snapshot) == true) {
              return Container();
            }
            return AppButton(
              color: AppColor.TOPAZ,
              child: _renderTextInButton(CONST_LOGINTEXT_SIGNUPTITLE),
              onPressed: () => _onTapSignInNavigation('/login'),
              //snapshot.data == true ? () {} : null,
            );
          }),
    );
  }

  void _onTapSignInNavigation(String route) {
    this._appBloc.getNavigator().pushReplacementNamed(route);
  }

  Widget _renderNavigatetoSignUp() {
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

  Widget _renderSocialMedia() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: <Widget>[
          AppButton(
              color: AppColor.DARKBLUEFACEBOOK,
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 0,
                      child: Image.asset(
                        AppImage.PATH_FACEBOOK_ICON,
                        fit: BoxFit.fill,
                      )),
                  Expanded(flex: 1, child: Text(' |')),
                  Expanded(
                    flex: 3,
                    child: _renderTextInButton(CONST_LOGINTEXT_FACEBOOK),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          AppButton(
            color: AppColor.REDGOOGLE,
            onPressed: () {},
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
                  child: _renderTextInButton(CONST_LOGINTEXT_GOOGLE),
                ),
              ],
            ),
          ),
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
          _renderNavigatetoSignUp(),
          Text(CONST_LOGINTEXT_OR,
              style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
          _renderSocialMedia()
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
