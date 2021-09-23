//@dart=2.9
import 'package:food_track/cache/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static CacheManager _instance;
  static SharedPreferences _prefrences;
  Future<CacheManager> cache() async {
    if (_instance == null) {
      _instance = CacheManager();
      _prefrences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  void storeCred(String phno, String uid) {
    _prefrences.setString(Keys.phno, phno);
    _prefrences.setString(Keys.uid, uid);
  }

  Future<String> getUID() async {
    return _prefrences.getString(Keys.uid);
  }

  Future<String> getPhno() async {
    return _prefrences.getString(Keys.phno);
  }

  Future<String> getType() async {
    return _prefrences.getString(Keys.type);
  }

  void storetype(String type) {
    _prefrences.setString(Keys.type, type);
  }

  Future removeCache() async {
    _prefrences.remove(Keys.phno);
    _prefrences.remove(Keys.type);
    _prefrences.remove(Keys.uid);
    _prefrences.remove(Keys.type);
  }
}
