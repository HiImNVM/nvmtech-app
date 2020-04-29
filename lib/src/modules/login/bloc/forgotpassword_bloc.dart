import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/src/app_bloc.dart';
import 'package:nvmtech/src/models/response_success_model.dart';
import 'package:nvmtech/src/modules/login/models/sendVerificationCde_model.dart';
import 'package:nvmtech/src/modules/login/repositories/forgotpassword_repo.dart';
import 'package:nvmtech/src/modules/login/types/forgotpassword_type.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/util/print_util.dart';
import 'package:nvmtech/src/util/validation_util.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc extends BlocBase {
  final BehaviorSubject<ForgotPasswordState> _forgotPasswordState =
      BehaviorSubject<ForgotPasswordState>.seeded(ForgotPasswordState.Default);
  Stream<ForgotPasswordState> get getStreamForgotPasswordType =>
      this._forgotPasswordState.stream;
  void sinkForgotPasswordType(ForgotPasswordState newForgotPasswordType) =>
      this._forgotPasswordState.sink.add(newForgotPasswordType);

  final BehaviorSubject<bool> _isEnableVerifyCode =
      BehaviorSubject<bool>.seeded(false);
  Stream<bool> get getStreamIsEnableVerifyCode =>
      this._isEnableVerifyCode.stream;
  void sinkIsEnableVerifyCode(bool newIsEnableVerifyCode) =>
      this._isEnableVerifyCode.sink.add(newIsEnableVerifyCode);

  void verifyPhoneNumber(context, String countryCode, String phoneNumber) {
    final bool isValid =
        Validation.validatePhoneNumber(countryCode + phoneNumber);
    this.sinkIsEnableVerifyCode(isValid);
  }

  Future<int> sendVerificationPhoneNumber(
      context, String countryCode, String phoneNumber) async {
    this.sinkForgotPasswordType(ForgotPasswordState.Loading);

    final ResponseModel responseModel = await ForgotPassword({
      'phonePrefix': countryCode,
      'phoneNumber': phoneNumber,
    }).sendVerificationCode();

    this.sinkForgotPasswordType(ForgotPasswordState.Default);

    if (responseModel is ErrorModel) {
      printInfo('Send verification code fail!');
      AppBloc.showToastMessage(
        context,
        responseModel.value,
        ToastType.Error,
      );

      return null;
    }

    printInfo('Send verification code success!');
    return ((responseModel as SuccessModel).value
            as ForgotPasswordSendVerificationCodeModel)
        .timeExpire;
  }

  @override
  void dispose() async {
    await this._forgotPasswordState?.drain();
    this._forgotPasswordState?.close();
  }
}
