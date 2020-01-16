import 'package:json_annotation/json_annotation.dart';
part 'response_error_model.g.dart';

@JsonSerializable()
class ResponseError {
  @JsonKey(name: 'statusCode')
  int statusCode;

  @JsonKey(name: 'err')
  String err;

  @JsonKey(name: 'errCode')
  int errCode;

  @JsonKey(name: 'message')
  String message;

  ResponseError({
    this.statusCode,
    this.err,
    this.errCode,
    this.message,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}
