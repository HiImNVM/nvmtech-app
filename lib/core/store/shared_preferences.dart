import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferences {
  String getToken();
  void setToken(String newToken);
  void clear();
  SharedPreferences getSPreferences();
}

class SharedPreferencesWrapper implements ISharedPreferences {
  static const String NAME_ACCESS_TOKEN = 'access_token';
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
  String getToken() => _preferences.get(NAME_ACCESS_TOKEN);

  @override
  void clear() => _preferences.clear();

  @override
  SharedPreferences getSPreferences() => _preferences;

  @override
  Future<bool> setToken(String newToken) async =>
      await _preferences.setString(NAME_ACCESS_TOKEN, newToken);
}
