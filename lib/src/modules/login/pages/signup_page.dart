import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/modules/login/bloc/login_bloc.dart';
import 'package:nvmtech/src/modules/login/bloc/signup_bloc.dart';
import 'package:nvmtech/src/util/printUtil.dart';

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
            }
          ),

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
            }
          ),
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
            }
          ),
        
        ])
    );
  }

  Widget _renderBody() {
    return Center(
      child: Column(
        children: <Widget>[
//        _rendersignInTitle(),
//
//        _renderLogo(),
//
          _renderNameEmailPassForm(),
//
//        _renderSignInButton(),
//
//        _renderNavigatetoSignUp(),
//
//        Text(loginText_or, style: AppTextStyle.LIGHTGREY_W600_NORMAL_F14),
//
//        _renderSocialMedia()
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
