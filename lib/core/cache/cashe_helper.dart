import 'package:selling_point_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> casheInit(key) async {
    print('init cash heloer');
    sharedPreferences = await SharedPreferences.getInstance();
    var res = await getData(key: key);
    var startDay = await getData(key: Constants.kstartDay);
    var getStudent = await getData(key: Constants.kfetchedStudent);
    // var getIsEnvelopeDone = await getData(key: Constants.kIsEnvelopeDone);
    // var spIsOrdered = await getData(key: Constants.kIsOrdered);
    if (res == null) {
      print('1111');
      await setData(key: key, value: 'ar');
    }
    print('res is : $res');
    if (startDay == null) {
      await setData(key: Constants.kstartDay, value: true);
    }
    if (getStudent == null) {
      await setData(key: Constants.kfetchedStudent, value: false);
    }
    // if (getIsEnvelopeDone == null) {
    //   await setData(key: Constants.kIsEnvelopeDone, value: false);
    // }
    // begin initialized
    // if (spIsOrdered == null) {
    //   await setData(key: Constants.kIsOrdered, value: false);
    // }
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> deleteData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<void> clearCashe() async {
    await sharedPreferences.clear();
  }
}
