import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/index.dart';
import 'package:nvmtech/core/widgets/loading/index_loading.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/components/button/index_button.dart';
import 'package:nvmtech/src/components/phonenumberInput/index.dart';
import 'package:nvmtech/src/modules/login/bloc/forgotpassword_bloc.dart';
import 'package:nvmtech/src/modules/login/constants/forgotpassword_constant.dart';
import 'package:nvmtech/src/modules/login/types/forgotpassword_type.dart';
import 'package:nvmtech/src/styles/color_style.dart';
import 'package:nvmtech/src/styles/image_style.dart';
import 'package:nvmtech/src/styles/margin_style.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';
import 'package:nvmtech/src/util/printUtil.dart';
import 'package:nvmtech/src/util/snapshotUtil.dart';

class ForgotPasswordPage extends StatelessWidget {
  final List<String> COUNTRY_CODE = const ['+84', '+96', '+97'];
  String _phoneNumber;

  ForgotPasswordBloc _forgotPasswordBloc;

  Widget _renderForgotPasswordTitle() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            CONST_TEXT_FORGOT_PASSWORD,
            style: AppTextStyle.BROWN_GREY_W700_F30,
          ),
        )
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

  Widget _renderInputPhoneNumber(context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width * 0.7;
    final double height = size.height * 0.07;

    return PhoneNumberInput(
      width: width,
      height: height,
      borderRadius: 6,
      contryCodes: COUNTRY_CODE,
      onChanged: (phone) => this._onChangePhoneNumber(context, phone),
    );
  }

  Widget _renderContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
      ),
      child: Text(
        CONST_CONTENT_FORGOT_PASSWORD,
        style: AppTextStyle.BROWN_GREY_W600_F14,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _renderBody(context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppDimension.PADDING),
          child: Center(
            child: Column(
              children: <Widget>[
                this._renderForgotPasswordTitle(),
                SizedBox(
                  height: 20,
                ),
                this._renderLogo(),
                SizedBox(
                  height: 30,
                ),
                this._renderInputPhoneNumber(context),
                SizedBox(
                  height: 20,
                ),
                this._renderContent(),
                SizedBox(
                  height: 20,
                ),
                this._renderButtonNavigateVerificationCode(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderButtonNavigateVerificationCode(context) {
    return StreamBuilder<bool>(
        stream: this._forgotPasswordBloc.getStreamIsEnableVerifyCode,
        builder: (context, snapshot) {
          if (!hasDataSnapshotUtil(snapshot)) {
            return Container();
          }

          return AppButton(
            child: Text('Verify Code'),
            color: AppColor.TOPAZ,
            onPressed:
                snapshot.data ? () => this._handleVerifyCode(context) : null,
          );
        });
  }

  Widget _renderModal() {
    return StreamBuilder<ForgotPasswordState>(
      stream: this._forgotPasswordBloc.getStreamForgotPasswordType,
      builder: (context, snapshot) {
        if (!hasDataSnapshotUtil(snapshot)) {
          return Container();
        }

        switch (snapshot.data) {
          case ForgotPasswordState.Loading:
            return LoadingWidget();
          default:
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    printCountBuild('_ForgotPasswordPageState');
    this._forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);

    return Stack(
      children: <Widget>[
        this._renderBody(context),
        this._renderModal(),
      ],
    );
  }

  void _onChangePhoneNumber(context, String newPhoneNumber) {
    this._phoneNumber = newPhoneNumber;
    this._forgotPasswordBloc.verifyPhoneNumber(context, newPhoneNumber);
  }

  void _handleVerifyCode(context) async {
    final int countDownCode = await this
        ._forgotPasswordBloc
        .sendVerificationPhoneNumber(context, this._phoneNumber);

    if (countDownCode == null || countDownCode == 0) {
      return;
    }

    BlocProvider.of<AppBloc>(context)
        .getNavigator()
        .pushNamed('/verificationCode');
  }
}
