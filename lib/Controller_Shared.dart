import 'package:shared_preferences/shared_preferences.dart';

class Controller_Shared {
  SharedPreferences? prefs;

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveShared(String key, String value) async {
    print('Guardando $key: $value');
    await prefs?.setString(key, value);
  }

  Future<String?> getShared(String key) async {
    if (prefs?.getString(key) == null) {
      return null;
    }
    return prefs?.getString(key);
  }

  Future<void> deleteShared(String key) async {
    prefs?.remove(key);
    print('Eliminando $key');
  }
}
