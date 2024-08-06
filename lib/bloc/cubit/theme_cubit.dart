import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallaryapp/constans/strings.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(bool isdark) : super(ThemeInitial()) {
    if (isdark) {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }
    emit(ChangeTheme(theme: theme));
  }
  late ThemeMode theme;
  Future<ThemeMode> changetheme({ThemeMode? th}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (th != null) {
      theme = th;
    } else if (theme == ThemeMode.dark) {
      theme = ThemeMode.light;
      await prefs.setBool(isdark_Pref, false);
    } else {
      theme = ThemeMode.dark;
      await prefs.setBool(isdark_Pref, true);
    }
    emit(ChangeTheme(theme: theme));
    return theme;
  }
}
