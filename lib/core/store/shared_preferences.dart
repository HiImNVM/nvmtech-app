import 'package:shared_preferences/shared_preferences.dart';

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
