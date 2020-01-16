import 'package:json_annotation/json_annotation.dart';
part 'loginWithEmail_model.g.dart';

@JsonSerializable()
class LoginWithEmailModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'refreshToken')
  String refreshToken;

  LoginWithEmailModel(
    this.id,
    this.refreshToken,
    this.token,
  );

  factory LoginWithEmailModel.fromJson(Map<String, dynamic> json) =>
      _$LoginWithEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWithEmailModelToJson(this);
}
