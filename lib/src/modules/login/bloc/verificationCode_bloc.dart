import 'package:nvmtech/core/api/index.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/src/bloc/app_bloc.dart';
import 'package:nvmtech/src/models/user_info_store_model.dart';
import 'package:nvmtech/src/modules/login/constants/verificationCode_constant.dart';
import 'package:nvmtech/src/modules/login/models/checkVerificationCode_model.dart';
import 'package:nvmtech/src/modules/login/repositories/forgotpassword_repo.dart';
import 'package:nvmtech/src/modules/login/types/verificationCode_type.dart';
import 'package:nvmtech/src/modules/login/models/sendVerificationCde_model.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/util/print_util.dart';
import 'package:rxdart/rxdart.dart';

class VerificationCodeBloc extends BlocBase {
  VerificationCodeBloc(int defaultTimeExpire) {
    this.sinkCountDownState(defaultTimeExpire);
  }

  final _verificationCodeState = BehaviorSubject<VerificationCodeState>.seeded(
      VerificationCodeState.Default);
  Stream<VerificationCodeState> get getStreamVerificationCodeType =>
      this._verificationCodeState.stream;
  void sinkVerificationCodeType(VerificationCodeState newVerificationCode) =>
      this._verificationCodeState.sink.add(newVerificationCode);

  final _countDownState = BehaviorSubject<int>();
  Stream<int> get getStreamCountDownState => this._countDownState.stream;
  void sinkCountDownState(int newCountDownState) =>
      this._countDownState.sink.add(newCountDownState);

  Future<bool> checkVerificationCode(context, String countryCode,
      String phoneNumber, String verificationCode) async {
    this.sinkVerificationCodeType(VerificationCodeState.Loading);

    final response = await ForgotPassword({
      'phonePrefix': countryCode,
      'phoneNumber': phoneNumber,
      'verificationCode': verificationCode,
    }).checkVerificationCode();

    this.sinkVerificationCodeType(VerificationCodeState.Default);

    if (response is ErrorModel) {
      printInfo('Check verification code fail!');
      AppBloc.showToastMessage(
        context,
        response.value,
        ToastType.Error,
      );
      return false;
    }

    printInfo('Check verification code success!');
    final isVerifySuccess =
        (((response as SuccessModel).value) as CheckVerificationCodeModel)
            .isVerifySuccess;

    if (isVerifySuccess == null || isVerifySuccess == false) {
      AppBloc.showToastMessage(
        context,
        CONST_VERIFY_CODE_FAIL,
        ToastType.Error,
      );
      return false;
    }

    return true;
  }

  void reSendVerificationCode(
      context, String countryCode, String phoneNumber) async {
    this.sinkVerificationCodeType(VerificationCodeState.Loading);

    final ResponseModel responseModel = await ForgotPassword({
      'phonePrefix': countryCode,
      'phoneNumber': phoneNumber,
    }).sendVerificationCode();

    this.sinkVerificationCodeType(VerificationCodeState.Default);

    if (responseModel is ErrorModel) {
      printInfo('Send verification code fail!');
      AppBloc.showToastMessage(
        context,
        responseModel.value,
        ToastType.Error,
      );
      return;
    }

    AppBloc.showToastMessage(
      context,
      'Send verification code success. Please check sms!',
      ToastType.Success,
    );
    printInfo('Send verification code success!');

    final timeExpire = ((responseModel as SuccessModel).value
            as ForgotPasswordSendVerificationCodeModel)
        .timeExpire;

    this.sinkCountDownState(timeExpire);
  }

  void _saveUserInfo(dynamic sp, dynamic userInfo) {
    final user = UserInfoStore.fromJson(userInfo);

    sp.wait([
      sp.setString(UserInfoStore.CONST_USER_ID, user.userId),
    ]);
  }

  @override
  void dispose() async {
    await this._verificationCodeState?.drain();
    this._verificationCodeState?.close();
  }
}
