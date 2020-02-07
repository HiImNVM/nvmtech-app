import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/widgets/loading/index_loading.dart';
import 'package:nvmtech/core/widgets/pinInput/index.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/appBar/index.dart';
import 'package:nvmtech/src/components/button/index.dart';
import 'package:nvmtech/src/components/coutDownTime/index.dart';
import 'package:nvmtech/src/components/layout/index.dart';
import 'package:nvmtech/src/modules/login/bloc/verificationCode_bloc.dart';
import 'package:nvmtech/src/modules/login/constants/verificationCode_constant.dart';
import 'package:nvmtech/src/modules/login/types/verificationCode_type.dart';
import 'package:nvmtech/src/params.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/print_util.dart';
import 'package:nvmtech/src/util/snapshot_util.dart';

class VerificationCodePage extends StatelessWidget {
  VerificationCodePage(this.verificationCodePageArgument);

  final VerificationCodePageArgument verificationCodePageArgument;
  final int PIN_LENGTH = 4;
  final TextEditingController _verificationCtrl = TextEditingController();

  VerificationCodeBloc _verificationCodeBloc;

  Widget _renderVerificationCodeTitle() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            CONST_TEXT_VERIFICATION_CODE,
            style: AppTextStyle.BROWN_GREY_W700_F30,
          ),
        ),
      ],
    );
  }

  Widget _renderLogo() {
    return Container(
        child: Image.asset(
      AppImage.PATH_MAIN_ICON,
      width: 80,
      height: 80,
      fit: BoxFit.fill,
    ));
  }

  Widget _renderVerificationCode(context) => PinInputTextField(
        pinLength: PIN_LENGTH,
        autoFocus: true,
        controller: this._verificationCtrl,
        onChanged: (text) => this._onChangePin(context, text),
        decoration: BoxLooseDecoration(
          gapSpace: 30,
        ),
      );

  Widget _renderShowContent() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Check your SMS messages, we have sent you the pin at ${this.verificationCodePageArgument.countryCode + this.verificationCodePageArgument.phoneNumber}',
          style: AppTextStyle.BLACK_W600_F14,
          textAlign: TextAlign.center,
        ),
      );

  Widget _renderCoutDownTime() {
    return StreamBuilder<int>(
        stream: this._verificationCodeBloc.getStreamCountDownState,
        builder: (context, snapshot) {
          if (!hasDataSnapshotUtil(snapshot)) {
            return Container();
          }

          return CountDownTime(
            time: snapshot.data,
            style: AppTextStyle.BLACK_WBOLD_F30,
          );
        });
  }

  Widget _renderReSendVerificationCode(context) {
    return AppButton(
      color: AppColor.TOPAZ,
      child: Text('ReSend Verification Code'),
      isShadow: true,
      onPressed: () => this._handleVerifyCode(context),
    );
  }

  Widget _renderBody(context) {
    return Scaffold(
      appBar: AppBarTransparent(),
      body: BodyLayout(
        child: Center(
          child: Column(
            children: <Widget>[
              this._renderVerificationCodeTitle(),
              SizedBox(
                height: 20,
              ),
              this._renderLogo(),
              SizedBox(
                height: 50,
              ),
              this._renderVerificationCode(context),
              SizedBox(
                height: 30,
              ),
              this._renderShowContent(),
              SizedBox(
                height: 20,
              ),
              this._renderCoutDownTime(),
              SizedBox(
                height: 20,
              ),
              this._renderReSendVerificationCode(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderModal() {
    return StreamBuilder<VerificationCodeState>(
      stream: this._verificationCodeBloc.getStreamVerificationCodeType,
      builder: (context, snapshot) {
        if (!hasDataSnapshotUtil(snapshot)) {
          return Container();
        }

        switch (snapshot.data) {
          case VerificationCodeState.Loading:
            return LoadingWidget();
          default:
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    printCountBuild('VerificationCodePage');
    this._verificationCodeBloc = BlocProvider.of<VerificationCodeBloc>(context);

    return Stack(
      children: <Widget>[
        this._renderBody(context),
        this._renderModal(),
      ],
    );
  }

  void _onChangePin(context, String charPin) async {
    if (charPin.length != PIN_LENGTH) {
      return;
    }

    final isVerifySuccess =
        await this._verificationCodeBloc.checkVerificationCode(
              context,
              this.verificationCodePageArgument.countryCode,
              this.verificationCodePageArgument.phoneNumber,
              charPin,
            );

    if (isVerifySuccess == false) {
      this._verificationCtrl.clear();
      return;
    }

    BlocProvider.of<AppBloc>(context)
        .getNavigator()
        .pushNamed('/home', arguments: {});
  }

  void _handleVerifyCode(context) =>
      this._verificationCodeBloc.reSendVerificationCode(
          context,
          this.verificationCodePageArgument.countryCode,
          this.verificationCodePageArgument.phoneNumber);
}
