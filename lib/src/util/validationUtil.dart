import 'package:nvmtech/src/constants/validationUtil_constant.dart';

class Validation{
  static String emailvalid = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String validateName(String name){
    if(name == null){
      return CONST_VALIDATION_NAMEISNULL;
    }
    if(name.isEmpty){
      return CONST_VALIDATION_ISEMPTY;
    }
    if(name.length < 30){
      return CONST_VALIDATION_ISNAMELENGTH;
    }
    return null;
  }
  
  static String validateEmail(String email){
    if(email == null){
      return CONST_VALIDATION_EMAILISNULL;
    }
    if(email.isEmpty){
      return CONST_VALIDATION_ISEMPTY;
    }
    var emailValid = RegExp(emailvalid)
      .hasMatch(email);
    if(!emailValid){
      return CONST_VALIDATION_EMAILISINVALID;
    }
    return null;
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