import 'package:json_annotation/json_annotation.dart';
part 'checkVerificationCode_model.g.dart';

@JsonSerializable()
class CheckVerificationCodeModel {
  @JsonKey(name: 'isVerifySuccess')
  bool isVerifySuccess;

  CheckVerificationCodeModel(
    this.isVerifySuccess,
  );

  factory CheckVerificationCodeModel.fromJson(Map<String, dynamic> json) =>
      _$CheckVerificationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckVerificationCodeModelToJson(this);
}
