import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('firstRun') ?? true) {
      clearPref();
      prefs.setBool('firstRun', false);
    }
  }

  static savePref(String key, String data) async {
    final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);
    final storage = new FlutterSecureStorage();
    await storage.write(key: key, value: data, iOptions: options);
  }

  static clearPref() {
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
  }

  static Future<String?> getAppSettings() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: 'appSettings');
  }

}
