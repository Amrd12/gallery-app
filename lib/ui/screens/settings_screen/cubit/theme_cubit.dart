import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/shared_pref/shared_pref.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(ThemeMode th) : super(ThemeInitial());
  final SharedPref _sharedPref = locator.get<SharedPref>();

  ThemeMode get theme => _sharedPref.isDark ? ThemeMode.dark : ThemeMode.light;

  Future<ThemeMode> changetheme() async {
    log("isDark : ${_sharedPref.isDark}\n theme :$theme");
    bool mood = !_sharedPref.isDark;
    await _sharedPref.toggleIsDark(mood);
    emit(ChangeTheme(theme: theme));
    log("isDark : ${_sharedPref.isDark}\n theme :$theme");
    return theme;
  }

  Future<void> fristRun() async {
    await _sharedPref.setFirstRun();
    emit(IsFirstRun(isFirstRun: false));
  }
}
