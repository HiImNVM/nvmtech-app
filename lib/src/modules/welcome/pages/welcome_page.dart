import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class WelcomePage extends StatelessWidget {
  AppBloc _appBloc;

  @override
  Widget build(BuildContext context) {
    this._appBloc = BlocProvider.of<AppBloc>(context);

    void _onPressedNextNavigation(String route) {
      this._appBloc.getNavigator().pushReplacementNamed(route);
    }

    Widget _renderAppBar(){
      return AppBar(
        title: Text('Welcome to social network'),
      );
    }
    Widget _renderNextButton(){
      return Container(
        padding: EdgeInsets.all(50),
      child: AppButton(
      color: AppColor.TOPAZ,
      onPressed: () => _onPressedNextNavigation('/login'),
      child: Text('Next'))
      );
    }
    return Scaffold(
      appBar: _renderAppBar(), 
      body: _renderNextButton()
    );
  }
}
