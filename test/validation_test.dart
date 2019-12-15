import 'package:flutter_test/flutter_test.dart';
import 'package:nvmtech/src/constants/validationUtil_constant.dart';
import 'package:nvmtech/src/util/validationUtil.dart';

void main() {
  group('Validation Test', () {
    test("Email is empty", () {
      var result = Validation.validateEmail('');
      expect(result, CONST_VALIDATION_ISEMPTY);
    });

    test("Email has no special characters", () {
      var result = Validation.validateEmail('crystal.ng285gmail');
      expect(result, CONST_VALIDATION_EMAILISINVALID);
    });

    test("Valid email test", () {
      var result = Validation.validateEmail('crystal.ng285@gmail.com');
      expect(result, null);
    });

    test("Password is empty", () {
      var result = Validation.validatePassword('');
      expect(result, CONST_VALIDATION_ISEMPTY);
    });

    test("Password is required minimum 7 characters", () {
      var result = Validation.validatePassword('tram');
      expect(result, CONST_VALIDATION_ISPASSLENGTH);
    });

    test("Valid password test", () {
      var result = Validation.validatePassword('crystalnguyen');
      expect(result, null);
    });
  });
}
