class ResponseModel {
  ResponseModel({
    this.value,
  });
  dynamic value;
}

class SuccessModel extends ResponseModel {
  @override
  dynamic value;

  SuccessModel({value}) : super(value: value);
}

class ErrorModel extends ResponseModel {
  @override
  dynamic value;

  ErrorModel({
    this.value,
  }) : super(value: value);
}
