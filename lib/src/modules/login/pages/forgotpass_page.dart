import 'package:flutter/material.dart';
import 'package:nvmtech/src/constants/login_constant.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              BackButton(
                color: Colors.black,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                CONST_FORGOTPASSTITLE,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: "NunitoSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Image(
              image: AssetImage("assets/images/AppIcon.png"),
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
          Text(
            CONST_FORGOTPASSTEXT,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "NunitoSans",
              fontStyle: FontStyle.normal,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 35),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                hintText: "Enter your email",
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: _conbutton,
            child: Image.asset("assets/images/Buttoncon.png"),
          ),
        ]),
      ));
  }
  
  void _conbutton() {
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => EnterPhoneNumber()),
//    );
  }
}
