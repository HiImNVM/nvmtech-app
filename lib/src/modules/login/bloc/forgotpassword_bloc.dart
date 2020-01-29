import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/models/response_error_model.dart';
import 'package:nvmtech/src/models/response_success_model.dart';
import 'package:nvmtech/src/modules/login/models/sendVerificationCde_model.dart';
import 'package:nvmtech/src/modules/login/repositories/forgotpassword_repo.dart';
import 'package:nvmtech/src/modules/login/types/forgotpassword_type.dart';
import 'package:nvmtech/src/util/printUtil.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc extends BlocBase {
  final BehaviorSubject<ForgotPasswordState> _forgotPasswordState =
      BehaviorSubject<ForgotPasswordState>.seeded(ForgotPasswordState.Default);
  ValueObservable<ForgotPasswordState> get getStreamForgotPasswordType =>
      this._forgotPasswordState.stream;
  void sinkForgotPasswordType(ForgotPasswordState newForgotPasswordType) =>
      this._forgotPasswordState.sink.add(newForgotPasswordType);

  final BehaviorSubject<bool> _isEnableVerifyCode =
      BehaviorSubject<bool>.seeded(false);
  ValueObservable<bool> get getStreamIsEnableVerifyCode =>
      this._isEnableVerifyCode.stream;
  void sinkIsEnableVerifyCode(bool newIsEnableVerifyCode) =>
      this._isEnableVerifyCode.sink.add(newIsEnableVerifyCode);

  void verifyPhoneNumber(context, String phoneNumber) {
    if (phoneNumber.isEmpty ||
        !RegExp(r'^\+[0-9]{2}[0-9]{9,10}$').hasMatch(phoneNumber)) {
      this.sinkIsEnableVerifyCode(false);
      return;
    }
    this.sinkIsEnableVerifyCode(true);
  }

  dynamic sendVerificationPhoneNumber(context, String phoneNumber) async {
    final String phonePrefix = phoneNumber.substring(0, 3);
    final String phone = phoneNumber.substring(3);

    this.sinkForgotPasswordType(ForgotPasswordState.Loading);

    final ResponseModel responseModel = await ForgotPassword({
      'phonePrefix': phonePrefix,
      'phoneNumber': phone,
    }).sendVerificationCode();

    this.sinkForgotPasswordType(ForgotPasswordState.Default);

    if (responseModel is ErrorModel) {
      printInfo('Send verification code fail!');
      AppBloc.showToastMessage(
        context,
        'Send verification code fail. Please try again!',
      );

      return null;
    }

    printInfo('Send verification code success!');
    final ForgotPasswordSendVerificationCodeModel
        forgotPasswordSendVerificationCodeModel =
        ForgotPasswordSendVerificationCodeModel.fromJson(
            (responseModel.value as ResponseSuccess).data);

    return forgotPasswordSendVerificationCodeModel.timeExpire;
  }

  @override
  void dispose() async {
    await this._forgotPasswordState?.drain();
    this._forgotPasswordState?.close();
  }
}
