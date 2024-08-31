import 'dart:developer';

import 'package:gallaryapp/constans/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late bool isFirstRun;
  late bool isDark;
  late SharedPreferences prefs;
  Future<void> toggleIsDark(bool mood) async =>
      await prefs.setBool(PrefNames.isdarkPref, isDark = mood);

  Future<void> setFirstRun() async =>
      await prefs.setBool(PrefNames.firstTimePref, isFirstRun = false);

  void setup() async {
    prefs = await SharedPreferences.getInstance();
    await _setupIsdark(prefs);
    isFirstRun = prefs.getBool(PrefNames.firstTimePref) ?? true;
  }

  Future<void> _setupIsdark(SharedPreferences prefs) async {
    bool? _isDark = prefs.getBool(PrefNames.isdarkPref);
    log("isdark $_isDark");
    if (_isDark == null) {
      await prefs.setBool(PrefNames.isdarkPref, true);
      _isDark = false;
    }
    isDark = _isDark;
  }
}
