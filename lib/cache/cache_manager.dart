//@dart=2.9
import 'package:food_track/cache/constants.dart';
import 'package:hive/hive.dart';

class CacheManager {
  static CacheManager _instance;
  CacheManager cache() {
    _instance ??= CacheManager();
    return _instance;
  }

  void storeCred(String phno, String type, String uid) {
    var box = Hive.box(Keys.cred);
    box.put(Keys.phno, phno);
    box.put(Keys.type, type);
    box.put(Keys.uid, uid);
  }

  String getPhoneNumber() => Hive.box(Keys.cred).get(Keys.phno);

  String getType() => Hive.box(Keys.cred).get(Keys.type);

  String getUID() => Hive.box(Keys.cred).get(Keys.uid);
}
