class ResponseError {
  static String getMessage(String aliasMessage) =>
      _mappingCodeError[aliasMessage] ?? ERROR_DEFAULT;

  static Map<String, String> _mappingCodeError = {
    '': '',
    '': '',
  };

  static const String ERROR_DEFAULT = 'Unknown error';
  static const String ERROR_NO_NETWORK =
      'Can\'t connect network. Please try again!';
}
