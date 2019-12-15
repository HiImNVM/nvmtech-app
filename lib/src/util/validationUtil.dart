import 'package:nvmtech/src/constants/validationUtil_constant.dart';

class Validation{
  static String emailvalid = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  
  static String validateEmail(String email){
    if(email == null){
      return CONST_VALIDATION_EMAILISNULL;
    }
    if(email.isNotEmpty){
      return CONST_VALIDATION_ISEMPTY;
    }
    var emailValid = RegExp(emailvalid)
      .hasMatch(email);
    if(!emailValid){
      return CONST_VALIDATION_EMAILISINVALID;
    }
    return '';
  }
  
  static String validatePassword(String password){
    if(password == null){
      return CONST_VALIDATION_PASSISNULL;
    }
    if(password.isEmpty){
      return CONST_VALIDATION_ISEMPTY;
    }
    if(password.length < 7){
      return CONST_VALIDATION_ISPASSLENGTH;
    }
    return null;
  }
}