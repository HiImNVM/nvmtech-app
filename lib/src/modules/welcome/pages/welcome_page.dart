import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/background/index_background.dart';
import 'package:nvmtech/src/components/dotIndicator/dotIndicator_index.dart';
import 'package:nvmtech/src/modules/welcome/models/introduce_model.dart';
import 'package:nvmtech/src/modules/welcome/welcome_constant.dart';
import 'package:nvmtech/src/styles/gradient_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/printUtil.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<IntroduceModel> _introduces = const [
    IntroduceModel(
      pathLeftImage: AppImage.PATH_IMG_SHOW_SCREEN_LEFT,
      pathCenterImage: AppImage.PATH_IMG_SHOW_SCREEN_CENTER,
      pathRightImage: AppImage.PATH_IMG_SHOW_SCREEN_RIGHT,
      title: CONST_TITLE_SEND_UNLIMITED_MESSAGES,
      content: CONST_CONTENT_AFTER_YOU_HAVE_REGISTERED,
    ),
    IntroduceModel(
      pathLeftImage: AppImage.PATH_IMG_SHOW_SCREEN_CENTER,
      pathCenterImage: AppImage.PATH_IMG_SHOW_SCREEN_RIGHT,
      pathRightImage: AppImage.PATH_IMG_SHOW_SCREEN_LEFT,
      title: CONST_TITLE_ENJOY_GROUP_CHAT,
      content: CONST_CONTENT_ENCRYPTED_BUSINESS,
    ),
    IntroduceModel(
      pathLeftImage: AppImage.PATH_IMG_SHOW_SCREEN_RIGHT,
      pathCenterImage: AppImage.PATH_IMG_SHOW_SCREEN_LEFT,
      pathRightImage: AppImage.PATH_IMG_SHOW_SCREEN_CENTER,
      title: CONST_TITLE_SHARE_AUDIO_VIDEO_PHOTO,
      content: CONST_CONTENT_REAL_TIME_STATS,
    ),
  ];
  AppBloc _appBloc;
  int _currentStep;
  double _angleDefault = pi / 18; // 30 angle

  @override
  void initState() {
    super.initState();

    this._currentStep = 0;
  }

  Widget _renderBaseShowScreen(context, String pathImg,
      [double width, double height]) {
    final Size size = MediaQuery.of(context).size;
    final double widthImage = width == null ? size.width * 0.53 : width;
    final double heightImage = height == null ? size.height * 0.56 : height;

    return Image.asset(
      pathImg,
      width: widthImage,
      height: heightImage,
      fit: BoxFit.contain,
    );
  }

  Widget _renderLeftShowScreen(context, String pathImg) {
    return Transform.rotate(
      angle: -this._angleDefault,
      child: this._renderBaseShowScreen(
        context,
        pathImg,
      ),
    );
  }

  Widget _renderRightShowScreen(context, String pathImg) {
    return Transform.rotate(
      angle: this._angleDefault,
      child: this._renderBaseShowScreen(
        context,
        pathImg,
      ),
    );
  }

  Widget _renderShowScreen(context, IntroduceModel introduceModel) {
    final Size size = MediaQuery.of(context).size;
    final double marginTop = size.height * 0.02;
    final double positionPadding = size.height / 7.5;
    final double positionTop = size.width * 0.25;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: marginTop),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: positionTop,
            left: -positionPadding,
            child: this._renderLeftShowScreen(
              context,
              introduceModel.pathLeftImage,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: this._renderBaseShowScreen(
              context,
              introduceModel.pathCenterImage,
            ),
          ),
          Positioned(
            top: positionTop,
            right: -positionPadding,
            child: this._renderRightShowScreen(
              context,
              introduceModel.pathRightImage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.WHITE_W700_NORMAL_F18,
      textAlign: TextAlign.center,
    );
  }

  Widget _renderContent(String content) {
    return Text(
      content,
      style: AppTextStyle.WHITE_W600_NORMAL_F14_H2,
      textAlign: TextAlign.center,
    );
  }

  Widget _renderLeftButton() {
    if (this._currentStep == 2) {
      return Container();
    }

    return GestureDetector(
        onTap: this._clickSkip,
        child: Opacity(
            opacity: 0.6,
            child: Text(CONST_SKIP,
                style: AppTextStyle.WHITE_W600_NORMAL_F14_H2)));
  }

  Widget _renderDots() {
    return AppDotIndicator(
      index: this._currentStep,
      length: this._introduces.length,
      defaultColorDot: Colors.white.withOpacity(0.6),
      selectedColorDot: Colors.white,
    );
  }

  Widget _renderRightButton() {
    final String textButton =
        this._currentStep != 2 ? CONST_NEXT : CONST_GET_STARTED;
    return GestureDetector(
      onTap: this._clickNext,
      child: Text(
        textButton,
        style: AppTextStyle.WHITE_W600_NORMAL_F14_H2,
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _renderTextIntroduce(context, IntroduceModel introduceModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradient.BLUE_GREEN_LINEARGRADIENT,
        image: DecorationImage(
          image: AssetImage(AppImage.PATH_BACKGROUND_IMAGE),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: Column(
          children: <Widget>[
            this._renderTitle(introduceModel.title),
            SizedBox(height: 20),
            this._renderContent(introduceModel.content),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex: 1, child: this._renderLeftButton()),
                  Expanded(flex: 2, child: this._renderDots()),
                  Expanded(flex: 1, child: this._renderRightButton()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    printCountBuild('_WelcomePageState');
    this._appBloc = BlocProvider.of<AppBloc>(context);

    final IntroduceModel introduceModel = this._introduces[this._currentStep];
    return AppBackground(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 2, child: this._renderShowScreen(context, introduceModel)),
          Expanded(
              flex: 1,
              child: this._renderTextIntroduce(context, introduceModel)),
        ],
      ),
    );
  }

  void _clickSkip() => this.setState(() => this._currentStep = 2);

  void _clickNext() {
    if (this._currentStep == 0 || this._currentStep == 1) {
      this.setState(() => this._currentStep = ++this._currentStep);
      return;
    }

    this._appBloc.getNavigator().pushReplacementNamed('/login');
  }
}
