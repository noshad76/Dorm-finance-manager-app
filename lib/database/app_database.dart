import 'package:hive/hive.dart';

class TokenBox {
  static const String _boxName = 'tokenBox';

  static Future<void> saveToken(String token) async {
    final box = await Hive.openBox(_boxName);
    await box.put('token', token);
  }

  static Future<void> removeToken() async {
    final box = await Hive.openBox(_boxName);
    await box.delete('token');
  }

  static Future<String?> getToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get('token');
  }

  static Future close() async {
    await Hive.close();
  }
}
