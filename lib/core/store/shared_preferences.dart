import 'package:shared_preferences/shared_preferences.dart';
//Suppose you wanna save a small value (a flag probably) 
// that you wanna refer later sometime when a user launches the application. 
// Then shared preference comes into action.
//lưu một giá trị nhỏ => giới thiệu sau này => Du lieu khoa gia tri
abstract class ISharedPreferences {
  String getToken();
  void clear();
  SharedPreferences getSPreferences();
}

class SharedPreferencesWrapper implements ISharedPreferences {
  static SharedPreferences _preferences;
  static SharedPreferencesWrapper _instance;

  static Future<SharedPreferencesWrapper> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesWrapper();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  @override
  String getToken() => _preferences.get("access_token");

  @override
  void clear() => _preferences.clear();

  @override
  SharedPreferences getSPreferences() => _preferences;
}
