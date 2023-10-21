import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {

    sharedPreferences= await SharedPreferences.getInstance();
  }


  static String? getString({
    required String key,
  })
  {
    return sharedPreferences?.getString(key);
  }

  static int? getInt({
    required String key,
  })
  {
    return sharedPreferences?.getInt(key);
  }

  static bool? getBool({
    required String key,
  })
  {
    return sharedPreferences?.getBool(key);
  }

  static Future<bool?> putBool({
    required key,
    required value
  }) async
  {
    return await sharedPreferences?.setBool(key, value);
  }

  static Future<bool?> putData({
    required String key,
    required value
  }) async
  {
    if(value is String){return await sharedPreferences?.setString(key, value);}
    if(value is bool){return await sharedPreferences?.setBool(key, value);}
    if(value is int){return await sharedPreferences?.setInt(key, value);}
    if(value is List<String>){return await sharedPreferences?.setStringList(key, value);}
    return await sharedPreferences?.setDouble(key, value);

  }
  static Future<bool>? removeData({
  required String key ,
}){
    return sharedPreferences?.remove(key);
  }
}