import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/widgets/loading/index_loading.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/types/login_type.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/margin_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/snapshotUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AppBloc _appBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _renderTextInButton(
    String text,
  ) {
    return Text(
      text,
      style: AppTextStyle.WHITE_W700_F16,
    );
  }

  Widget _renderSignInTitle() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            CONST_SIGNIN_TITLE,
            style: AppTextStyle.BROWN_GREY_W700_F30,
          ),
        )
      ],
    );
  }

  Widget _renderLogo() {
    return Container(
        child: Image.asset(
      AppImage.PATH_MAIN_ICON,
      width: 80,
      height: 80,
      fit: BoxFit.fill,
    ));
  }

  Widget _renderTextEmail() {
    return StreamBuilder<String>(
        stream: this._loginBloc.getStreamEmail,
        builder: (context, snapshot) {
          if (!hasDataSnapshotUtil(snapshot)) {
            return Container();
          }

          return TextField(
            autocorrect: false,
            controller: this._emailController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: CONST_TEXT_LOGIN_EMAIL,
              errorText: snapshot.data.isNotEmpty ? snapshot.data : null,
            ),
            keyboardType: TextInputType.emailAddress,
          );
        });
  }

  Widget _renderTextPassword() {
    return StreamBuilder<String>(
        stream: this._loginBloc.getStreamPassword,
        builder: (context, snapshot) {
          if (!hasDataSnapshotUtil(snapshot)) {
            return Container();
          }

          return TextFormField(
            style: AppTextStyle.BLACK_W600_NORMAL_F14,
            controller: this._passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: CONST_TEXT_LOGIN_PASSWORD,
              errorText: snapshot.data.isNotEmpty ? snapshot.data : null,
            ),
            keyboardType: TextInputType.visiblePassword,
          );
        });
  }

  Widget _renderEmailPassForm() {
    return Column(
      children: <Widget>[
        this._renderTextEmail(),
        SizedBox(height: 20),
        this._renderTextPassword(),
        SizedBox(height: 15),
        this._renderForgotPassword()
      ],
    );
  }

  Widget _renderForgotPassword() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      GestureDetector(
          onTap: this._navigateForgotPassword,
          child: Opacity(
            opacity: 0.7,
            child: Text(CONST_FORGOT_PASS_TITLE,
                style: AppTextStyle.BROWN_GREY_W600_F14),
          )),
    ]);
  }

  Widget _renderSignInButton() => AppButton(
      color: AppColor.TOPAZ,
      child: _renderTextInButton(CONST_SIGNIN_TITLE),
      onPressed: this._handleSignIn);

  Widget _renderNavigatetoSignUp() {
    final TextStyle signupTextStyle = AppTextStyle.BROWN_GREY_W600_F12.copyWith(
        fontFamily: 'NunitoSans-SemiBold', color: const Color(0xff676767));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Don't" + CONST_TEXT_LOGIN_SIGNIN,
            style: AppTextStyle.BROWN_GREY_W600_F14),
        GestureDetector(
            onTap: this._navigateSignup,
            child: Text(CONST_LOGINTEXT_SIGNUPTITLE, style: signupTextStyle)),
      ],
    );
  }

  Widget _renderBaseLoginWith(
      Color color, Function() onPressed, String pathImage, String content) {
    return AppButton(
        height: 55,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: color,
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Image.asset(
                  pathImage,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  '|',
                  style: TextStyle(color: Colors.grey[500], fontSize: 20),
                  textAlign: TextAlign.center,
                )),
            Expanded(
              flex: 10,
              child: Text(
                content,
                style: AppTextStyle.WHITE_W700_F16,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }

  Widget _renderLoginWithFB() {
    return this._renderBaseLoginWith(AppColor.BLUE_FACEBOOK, this._loginWithFB,
        AppImage.PATH_FACEBOOK_ICON, CONST_TEXT_LOGIN_FACEBOOK);
  }

  Widget _renderLoginWithGG() {
    return this._renderBaseLoginWith(AppColor.RED_GOOGLE, this._loginWithGG,
        AppImage.PATH_GOOGLE_ICON, CONST_LOGINTEXT_GOOGLE);
  }

  Widget _renderSocialMedia() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: Column(
          children: <Widget>[
            this._renderLoginWithFB(),
            SizedBox(
              height: 10,
            ),
            this._renderLoginWithGG(),
          ],
        ),
      ),
    );
  }

  Widget _renderBody(context) {
    double marginTop = MediaQuery.of(context).size.height * 0.1;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        padding: const EdgeInsets.symmetric(horizontal: AppDimension.PADDING),
        child: Center(
          child: Column(
            children: <Widget>[
              this._renderSignInTitle(),
              SizedBox(
                height: 10,
              ),
              this._renderLogo(),
              SizedBox(
                height: 30,
              ),
              this._renderEmailPassForm(),
              SizedBox(
                height: 30,
              ),
              this._renderSignInButton(),
              SizedBox(
                height: 30,
              ),
              this._renderNavigatetoSignUp(),
              SizedBox(
                height: 15,
              ),
              Text(CONST_TEXT_LOGIN_OR,
                  style: AppTextStyle.BROWN_GREY_W600_F14),
              SizedBox(
                height: 15,
              ),
              this._renderSocialMedia(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderModal() {
    return StreamBuilder<LoginState>(
      stream: this._loginBloc.getStreamLoginType,
      builder: (context, snapshot) {
        if (!hasDataSnapshotUtil(snapshot)) {
          return Container();
        }

        switch (snapshot.data) {
          case LoginState.Loading:
            return LoadingWidget();
          default:
            return Container();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this._emailController.addListener(() {
      _loginBloc.validateEmail(_emailController.text);
    });

    this._passwordController.addListener(() {
      _loginBloc.validatePassword(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    this._appBloc = BlocProvider.of<AppBloc>(context);
    this._loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          this._renderBody(context),
          this._renderModal(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    this._emailController?.dispose();
    this._passwordController?.dispose();
    super.dispose();
  }

  void _navigateForgotPassword() =>
      this._appBloc.getNavigator().pushNamed('/forgotpassword');

  void _navigateSignup() => this._appBloc.getNavigator().pushNamed('/signup');

  void _loginWithFB() {}

  void _loginWithGG() {}

  void _handleSignIn() => this._loginBloc.loginWithEmail(
        context,
        this._emailController.text,
        this._passwordController.text,
      );
}
