import 'package:json_annotation/json_annotation.dart';
part 'sendVerificationCde_model.g.dart';

@JsonSerializable()
class ForgotPasswordSendVerificationCodeModel {
  @JsonKey(name: 'timeExpire')
  int timeExpire;

  ForgotPasswordSendVerificationCodeModel(
    this.timeExpire,
  );

  factory ForgotPasswordSendVerificationCodeModel.fromJson(
          Map<String, dynamic> json) =>
      _$ForgotPasswordSendVerificationCodeModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ForgotPasswordSendVerificationCodeModelToJson(this);
}
