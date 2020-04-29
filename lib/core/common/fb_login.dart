import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class IFaceBookLogin {
  Future<FacebookLoginStatus> loginWithFB();
  Future<void> logoutFB();
}

class FBLoginImp implements IFaceBookLogin {
  factory FBLoginImp(List<String> _pers) => FBLoginImp._internal(_pers);
  FBLoginImp._internal(this._permissionsRequest);

  FacebookLogin _fbLogin = FacebookLogin();
  List<String> _permissionsRequest;
  String _token;

  String get getToken => this._token;
  List<String> get getPermissions => this._permissionsRequest;
  set setPermissionsRequest(List<String> pers) =>
      this._permissionsRequest = pers;

  @override
  Future<FacebookLoginStatus> loginWithFB() async {
    // force logout fb
    await this.logoutFB();
    return this
        ._fbLogin
        .logIn(this._permissionsRequest)
        .then((FacebookLoginResult facebookLoginResult) {
      this._setTokenAfterLoggedIn(facebookLoginResult);
      return facebookLoginResult.status;
    }).catchError((_) => FacebookLoginStatus.error);
  }

  @override
  Future<void> logoutFB() => this._fbLogin?.logOut();

  void _setTokenAfterLoggedIn(FacebookLoginResult facebookLoginResult) {
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      this._token = facebookLoginResult.accessToken.token;
    }
  }
}
