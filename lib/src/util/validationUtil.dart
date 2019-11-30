class Validation{
  static String abc = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  
  
  
  static String validateEmail(String email){
    if(email == null){
      return "Email is invalid because of null";
    }
    if(email == email.isEmpty){
      return "You have to fill in the blank";
    }
    var emailValid = RegExp(abc)
      .hasMatch(email);
    if(!emailValid){
      return "Email is invalid";
    }
    return null;
  }
  
  static String validatePassword(String password){
    if(password == null){
      return "Password is invalid because of null";
    }
    if(password == password.isEmpty){
      return "You have to fill in the blank";
    }
    if(password.length < 7){
      return "Password require minimum 7 characters!";
    }
    return null;
  }
}
//email - password