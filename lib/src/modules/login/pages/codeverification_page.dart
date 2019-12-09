import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/pinbox/index_pinbox.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/models/phone_model.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class CodeVerificationPage extends StatefulWidget {
  CodeVerificationPage({
    this.phonetext,
    this.phonemodel,
  });
  PhoneModel phonemodel;
  String phonetext;

  @override
  _CodeVerificationPageState createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  AppBloc _appBloc;
  List<TextEditingController> _controllers;
  int count;
  @override
  void initState() {
    super.initState();
    _controllers = <TextEditingController>[
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    
    count = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget _renderCodeTitle() {
    return Row(
      children: <Widget>[
        Text(
          CONST_CODE_TITLE,
          style: AppTextStyle.BLACK_W700_NORMAL_F30,
        ),
      ],
    );
  }

  Widget _renderLogo() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 40),
        child: Image.asset(AppImage.PATH_MAIN_ICON, width: 80, height: 80));
  }

  Widget _renderIntroduceText() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 35, horizontal: 40),
        child: RichText(
          text: TextSpan(
              text: CONST_CODE_TEXT,
              children: [
                TextSpan(
                    text: this.widget.phonetext,
                    style: AppTextStyle.BROWNISHGREY_W600_NORMAL_F14),
              ],
              style: AppTextStyle.BROWNISHGREY_W600_NORMAL_F14),
          textAlign: TextAlign.center,
        ));
  }

  List<Widget> _renderpinBoxs(List<TextEditingController> listtextcontroller,
      Color boxColor, Color textColor, int c) {
    List<Widget> boxs = List();
    List<FocusNode> focusNodes = List();
    focusNodes.add(FocusNode());
    c = count;
    c = listtextcontroller.length;

    for (int i = 0; i < listtextcontroller.length; i++) {
      focusNodes.add(FocusNode());
      if (i == listtextcontroller.length - 1) {
        focusNodes[i + 1].unfocus();
      }

      boxs.add(PinBox(
        controller: listtextcontroller[i],
        focusNode: focusNodes[i],
        nextFocusNode: focusNodes[i + 1],
        color: boxColor,
        textColor: textColor,
      ));
    }
    return boxs;
  }

  Widget _renderPinPutForm() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            _renderpinBoxs(_controllers, AppColor.BROWNGREY, Colors.black, count),
      ),
    );
  }

  void _onTapNavigation(String route) {
    this._appBloc.getNavigator().pushNamed(route);
  }

  Widget _renderReceiveSMSButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          FlatButton(
            onPressed: () => _onTapNavigation('/home'),
            color: AppColor.LIGHTBLUEGREY,
            child: Text(CONST_CODE_TEXTBUTTON,
                style: AppTextStyle.BROWNISHGREY_W600_NORMAL_F14,
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }

  Widget _renderBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(
        children: <Widget>[
          _renderCodeTitle(),
          _renderLogo(),
          _renderPinPutForm(),
          _renderIntroduceText(),
          _renderReceiveSMSButton()
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    _appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(body: _renderBody());
  }
}
