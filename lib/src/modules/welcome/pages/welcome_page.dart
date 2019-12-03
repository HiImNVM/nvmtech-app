import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/src/components/background/index_background.dart';
import 'package:nvmtech/src/constants/welcome_constant.dart';
import 'package:nvmtech/src/styles/gradient_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class WelcomePage extends StatelessWidget {
  Widget _renderPhoneScreen() {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Image.asset(
                WelcomeImage.WELCOME_CHATSCREENLEFT,
              ),
            ),
            
          ],
        ),
        Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                child: Image.asset(
                  WelcomeImage.WELCOME_PHONEFRAME,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Image.asset(
                  WelcomeImage.WELCOME_CHATSCREEN,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Image.asset(
                WelcomeImage.WELCOME_CHATSCREENRIGHT,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _renderTextIntroduce() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
      child: Column(
        children: <Widget>[
          Text(
            CONST_WELCOME_ONBOARDING1_TITLE,
            style: AppTextStyle.WHITE_W700_NORMAL_F18,
          ),
          SizedBox(height: 25),
          Text(
            CONST_WELCOME_ONBOARDING1_CONTENT,
            style: AppTextStyle.OFFWHITE_W600_NORMAL_F14,
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(CONST_WELCOME_SKIP,
                    style: AppTextStyle.OFFWHITE_W600_NORMAL_F14),
                Text(CONST_WELCOME_NEXT,
                    style: AppTextStyle.OFFWHITE_W600_NORMAL_F14)
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        child: Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(child: _renderPhoneScreen()),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.PATH_BACKGROUND_IMAGE),
                fit: BoxFit.cover,
              ),
              gradient: AppGradient.BLUEGREEN,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            width: double.infinity,
            child: _renderTextIntroduce(),
          ),
        )
      ],
    ));
  }
}
