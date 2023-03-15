import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  StoreService._();

  static const String _tokenKey = 'TOKEN';

  static Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  static Future<void> clear() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
