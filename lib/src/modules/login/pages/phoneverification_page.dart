import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/constants/login_constant.dart';
import 'package:nvmtech/src/modules/login/models/phone_model.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/validationUtil.dart';

import 'codeverification_page.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();

}

class _PhoneVerificationState extends State<PhoneVerificationPage>{
  AppBloc _appBloc;
  List<PhoneModel> _listphone = PhoneModel.listPhone.toList();
  List<DropdownMenuItem<PhoneModel>> _dropDownMenuItems;
  PhoneModel _currentPhone;
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems(_listphone);
    _currentPhone = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<PhoneModel>> getDropDownMenuItems(List listphone) {
    List<DropdownMenuItem<PhoneModel>> items = List();
    for (PhoneModel countrycode in listphone) {
      items.add(
          DropdownMenuItem(value: countrycode, child: Text(countrycode.code)));
    }
    return items;
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
        margin: EdgeInsets.symmetric(vertical: 40),
        child: Image.asset(AppImage.PATH_MAIN_ICON, width: 80, height: 80));
  }

  void _onchangedDropDownItem(PhoneModel selectedPhone) {
    setState(() {
      _currentPhone = selectedPhone;
    });
  }
  String _validatePhone (String value) {
    
    return Validation.validatePhone(value);
  }
  
  String _onchanged (String value){
    if(_validatePhone(value) == ''){
      setState(() {
        _onTapNavigation('/codeverification');
      });
    }
    return '';
  }
  
  Widget _renderPhoneForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: DropdownButtonFormField(
              value: _currentPhone,
              items: _dropDownMenuItems,
              onChanged: _onchangedDropDownItem,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: 2),
              child: TextFormField(
                onChanged: _onchanged,
               autovalidate: true,
                textInputAction: TextInputAction.done,
                validator: _validatePhone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: CONST_PHONE_TITLE,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderIntroduceText() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 35, horizontal: 40),
        child: Text(
          CONST_PHONE_TEXT,
          style: AppTextStyle.BROWNISHGREY_W600_NORMAL_F14,
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

class CodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CodeVerificationPage(
       phonetext: "1647781526",
      )
    );
  }
}

