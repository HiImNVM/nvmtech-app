import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FBLoginImp _fbLoginImp = FBLoginImp();
  String _token = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('$_token'),
        ),
        body: RaisedButton(
          onPressed: () {
            // _fbLoginImp.loginWithFB().then((FacebookLoginStatus status) {
            //   if (status == FacebookLoginStatus.error) {
            //     this._token = 'Error';
            //   } else {
            //     this._token = _fbLoginImp.getToken;
            //   }
            //   this.setState(() {});
            // });
          },
        ),
      ),
    );
  }
}
