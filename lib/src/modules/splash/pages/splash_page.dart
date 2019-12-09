import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/background/index_background.dart';
import 'package:nvmtech/src/constants/resource_constant.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class SplashPage extends StatelessWidget {
  SplashPage() {
    Future.delayed(
        Duration(milliseconds: 10000), () => this._appBloc.setupApp());
  }

  AppBloc _appBloc;

  Widget _renderAppIcon() {
    return Image.asset(
      AppImage.PATH_MAIN_ICON,
      width: 120,
      height: 120,
      fit: BoxFit.fill,
    );
  }

  Widget _renderSlogan() {
    return Text(
      APP_SLOGAN,
      style: AppTextStyle.TOPAZ_W400_NORMAL_F16,
    );
  }

  @override
  Widget build(BuildContext context) {
    // To load resource and setup config of app
    this._appBloc = BlocProvider.of<AppBloc>(context);

    return AppBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this._renderAppIcon(),
            SizedBox(
              height: 30,
            ),
            this._renderSlogan(),
          ],
        ),
      ),
    );
  }
}
