import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallaryapp/constans/strings.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(ThemeMode th, Locale lo) : super(ThemeInitial(th: th, lo: lo)) {
    theme = th;
    locale = lo;
  }

  late ThemeMode theme;
  late Locale locale;

  Future<ThemeMode> changetheme({ThemeMode? th}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (th != null) {
      theme = th;
    } else if (theme == ThemeMode.dark) {
      theme = ThemeMode.light;
      await prefs.setBool(isdark_Pref, false);
      print("set to light");
    } else {
      theme = ThemeMode.dark;
      await prefs.setBool(isdark_Pref, true);
      print("set to dark");
    }
    emit(ChangeTheme(theme: theme));
    return theme;
  }

  Future<Locale> changeLocale({Locale? th}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (th != null) {
      locale = th;
    } else if (locale == Locale("en")) {
      locale = Locale("ar");
      await prefs.setBool(isen_Pref, false);
      print("set to ar");
    } else {
      locale = Locale("en");
      await prefs.setBool(isen_Pref, true);
      print("set to en");
    }
    emit(ChangeLocale(locale: locale));
    return locale;
  }

  void FiristRun(bool isFirstRun) => emit(IsFirstRun(isFirstRun: isFirstRun));
}
