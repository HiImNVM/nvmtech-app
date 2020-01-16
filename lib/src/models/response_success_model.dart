import 'package:json_annotation/json_annotation.dart';
part 'response_success_model.g.dart';

@JsonSerializable()
class ResponseSuccess {
  @JsonKey(name: 'statusCode')
  int statusCode;

  @JsonKey(name: 'data')
  dynamic data;

  ResponseSuccess({
    this.statusCode,
    this.data,
  });

  factory ResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$ResponseSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSuccessToJson(this);
}
