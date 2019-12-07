import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:nvmtech/src/util/validationUtil.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerificationPage> {
 AppBloc _appBloc;
  String phoneNumber;
  String phoneIsoCode;
  bool _flag;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _flag = false;
    phoneNumber = '';
    phoneIsoCode = '';
  }
  
  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
      _flag = true;
      if(Validation.validatePhone(phoneNumber) == null){
        _onTapNavigation('/codeverification');
        print("check null");
      }
      else         print("check false");
//      if (number.length >= 5) {
//        print("number = ${number}");
//        _onTapNavigation('/codeverification');
//      } else {
//        //_ackAlert(context);
//      }
    }
    );
  }
  
  void _onTapNavigation(String route) {
      this._appBloc.getNavigator().pushNamed(route);
  }
  @override
  Widget _renderPhoneVerificationTitle() {
    return Row(
      children: <Widget>[
        Text(
          CONST_PHONE_TITLE,
          style: AppTextStyle.BLACK_W700_NORMAL_F30,
        ),
      ],
    );
  }

  Widget _renderLogo() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        child: Image.asset(AppImage.PATH_MAIN_ICON, width: 80, height: 80));
  }

  Widget _renderPhoneForm() {
    return Container(
      padding: EdgeInsets.all(20),
//      child: InternationalPhoneInput(
//        hintText: "Mobile Number",
//        errorText: Validation.validatePhone(phoneNumber),
//        onPhoneNumberChange: onPhoneNumberChange,
//        initialPhoneNumber: phoneNumber,
//        initialSelection: phoneIsoCode,
//      ),
    child: TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        hintText: CONST_PHONE_TITLE,
      ),
      
    ),
    );
  }

  Widget _renderIntroduceText() {
    return Container(
        child: Text(
      CONST_PHONE_TEXT,
      style: AppTextStyle.BLACK_W700_NORMAL_F18,
      textAlign: TextAlign.center,
    ));
  }

  Widget _renderBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(
        children: <Widget>[
          _renderPhoneVerificationTitle(),
          _renderLogo(),
          _renderPhoneForm(),
          _renderIntroduceText(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
   _appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: _renderBody(),
    );
  }
}
