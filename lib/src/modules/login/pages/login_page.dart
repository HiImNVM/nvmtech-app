import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/widgets/loading/index_loading.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/components/modal/success_modal.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/types/login_type.dart';
import 'package:nvmtech/src/util/printUtil.dart';
import 'package:nvmtech/src/util/snapshotUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AppBloc _appBloc;

  //Khai bao controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //listen textchange tu textform(user interaction) roi add vao stream(output)
    emailController.addListener(() {
      LoginBloc.of(context).emailSink.add(emailController.text);
    });

    passwordController.addListener(() {
      LoginBloc.of(context).passwordSink.add(passwordController.text);
    });
  }
  
  Widget _renderTextInButton(String text) {
    return Text(
      text,
      style: AppTextStyle.WHITE_W700_NORMAL_F16,
    );
  }

  Widget _rendersignInTitle() {
    return Row(
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

  Widget _renderEmailPassForm() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
            stream: _loginBloc.emailStream,
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
            }
          ),
          StreamBuilder<String>(
            stream: _loginBloc.passwordStream,
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
            }
          ),
        ],
      ),
    );
  }

  Widget _renderSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: StreamBuilder<bool>(
        stream: _loginBloc.btnStream,
        builder: (context, snapshot) {

          if(snapshotUtil(snapshot) == false){
            return Container();
          }
          
          return 
            AppButton(
            color: AppColor.TOPAZ,
            onPressed:
            snapshot.data == true ? ()
            {
//              Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(builder: (_) => HomePage()),
//              );
            } : null,
            child: _renderTextInButton(loginText_signintitle),
          );
        }
      ),
    );
  }

  Widget _renderNavigatetoSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 24)),
        Text("Don't" + loginText_signin,
            style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
        GestureDetector(
          onTap: (){
            this._appBloc.getNavigator().pushReplacementNamed('/signup');
          },
          child: Text(loginText_signuptitle, style: AppTextStyle.BLACK_W600_NORMAL_F12)),
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
              child: _renderTextInButton('Login with Facebook')),
          SizedBox(
            height: 10,
          ),
          AppButton(
            color: AppColor.REDGOOGLE,
            onPressed: () => this._loginBloc.sinkLoginType(LoginState.Success),
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
    );
  }

  Widget _renderBody(loginState, context) {
    return Center(
      child: Column(
        children: <Widget>[
          _rendersignInTitle(),
          
          _renderLogo(),
          
          _renderEmailPassForm(),
          
          _renderSignInButton(),
          
          _renderNavigatetoSignUp(),
          
          Text(loginText_or, style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
          
          _renderSocialMedia()
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
    this._appBloc = BlocProvider.of<AppBloc>(context);
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
