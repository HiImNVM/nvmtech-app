import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/background/index_background.dart';
import 'package:nvmtech/src/constants/welcome_constant.dart';
import 'package:nvmtech/src/styles/gradient_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBackground(child: Welcome_Page()));
  }
}

class Welcome_Page extends StatefulWidget {
  @override
  _Welcome_PageState createState() => _Welcome_PageState();
}

class _Welcome_PageState extends State<Welcome_Page> {
  String _B1texttitle;
  String _B1textcontent;
  String _B2texttitle;
  String _B2textcontent;
  String _B3texttitle;
  String _B3textcontent;

  String _B1screenleft;
  String _B2screenleft;
  String _B3screenleft;

  String _B1screencenter;
  String _B2screencenter;
  String _B3screencenter;

  String _B1screenright;
  String _B2screenright;
  String _B3screenright;

  int count;
  bool _flagnext;
  bool _flagskip;
  String _btnNext;
  String _btnSkip;
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _flagskip = true;
    _flagnext = true;
    count = 0;
    _B1texttitle = CONST_WELCOME_ONBOARDING1_TITLE;
    _B1textcontent = CONST_WELCOME_ONBOARDING1_CONTENT;

    _B2texttitle = CONST_WELCOME_ONBOARDING2_TITLE;
    _B2textcontent = CONST_WELCOME_ONBOARDING2_CONTENT;

    _B3texttitle = CONST_WELCOME_ONBOARDING3_TITLE;
    _B3textcontent = CONST_WELCOME_ONBOARDING3_CONTENT;

    _B1screenleft = WelcomeImage.WELCOME_B1_SCREENLEFT;
    _B2screenleft = WelcomeImage.WELCOME_B2_SCREENLEFT;
    _B3screenleft = WelcomeImage.WELCOME_B3_SCREENLEFT;

    _B1screencenter = WelcomeImage.WELCOME_B1_SCREENCENTER;
    _B2screencenter = WelcomeImage.WELCOME_B2_SCREENCENTER;
    _B3screencenter = WelcomeImage.WELCOME_B3_SCREENCENTER;

    _B1screenright = WelcomeImage.WELCOME_B1_SCREENRIGHT;
    _B2screenright = WelcomeImage.WELCOME_B2_SCREENRIGHT;
    _B3screenright = WelcomeImage.WELCOME_B3_SCREENRIGHT;

    _btnNext = CONST_WELCOME_NEXT;
    _btnSkip = CONST_WELCOME_SKIP;
  }

  Widget _renderPhoneScreen() {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Image.asset(
                _B1screenleft,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Image.asset(
                _B1screencenter,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Image.asset(
                _B1screenright,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _onTapLoginNavigation(String route) {
    this._appBloc.getNavigator().pushReplacementNamed(route);
  }

  void _onTapButton(int totalcount) {
    count++;
    totalcount += count;

    if (totalcount == 1) {
      return setState(() {
        _B1texttitle = _B2texttitle;
        _B1textcontent = _B2textcontent;
        _B1screenleft = _B2screenleft;
        _B1screencenter = _B2screencenter;
        _B1screenright = _B2screenright;
      });
    }
    if (totalcount > 1) {
      _flagnext = false;

      return setState(() {
        _B1screenleft = _B3screenleft;
        _B1screenright = _B3screenright;
        _B1screencenter = _B3screencenter;

        _B1texttitle = _B3texttitle;
        _B1textcontent = _B3textcontent;
        _btnSkip = '';
      });
    }
  }

  Widget _renderTextIntroduce() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
      child: Column(
        children: <Widget>[
          Text(
            _B1texttitle,
            style: AppTextStyle.WHITE_W700_NORMAL_F18,
          ),
          SizedBox(height: 25),
          Text(
            _B1textcontent,
            style: AppTextStyle.OFFWHITE_W600_NORMAL_F14,
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: 0.6000000238418579,
                  child: GestureDetector(
                      onTap: () {
                        if (_flagskip == true) {
                          count = 2;
                          _onTapButton(count);
                        }
                      },
                      child: Text(
                          _flagskip == false ? CONST_WELCOME_SKIP : _btnSkip,
                          style: AppTextStyle.OFFWHITE_W600_NORMAL_F14)),
                ),
                GestureDetector(
                  onTap: () {
                    if (_flagnext == true) {
                      _onTapButton(count);
                      return;
                    }
                    
                    _onTapLoginNavigation('/login');
                  },
                  child: Text(
                      _flagnext == true ? _btnNext : CONST_WELCOME_GETSTARTED,
                      style: AppTextStyle.OFFWHITE_W600_NORMAL_F14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _renderTextBox() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.PATH_BACKGROUND_IMAGE),
          fit: BoxFit.cover,
        ),
        gradient: AppGradient.BLUE_GREEN_LINEARGRADIENT,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      width: double.infinity,
      child: _renderTextIntroduce(),
    );
  }

  @override
  Widget build(BuildContext context) {
    this._appBloc = BlocProvider.of<AppBloc>(context);

    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: _renderPhoneScreen(),
        ),
        Expanded(
          flex: 1,
          child: _renderTextBox(),
        )
      ],
    );
  }
}
