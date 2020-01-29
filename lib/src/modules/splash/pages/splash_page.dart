import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/background/index_background.dart';
import 'package:nvmtech/src/constants/resource_constant.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/printUtil.dart';

class SplashPage extends StatelessWidget {
  Widget _renderAppIcon() {
    return Image.asset(
      AppImage.PATH_MAIN_ICON,
      width: 100,
      height: 100,
      fit: BoxFit.fill,
    );
  }

  Widget _renderSlogan() {
    return Text(
      APP_SLOGAN,
      style: AppTextStyle.BLACK_W400_NORMAL_F16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc _appBloc = BlocProvider.of<AppBloc>(context);
    printCountBuild('Build SplashPage');
    Future.delayed(Duration(seconds: 3), () => _appBloc.setupApp());
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
