import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  ThemeMode theme = ThemeMode.light;
  ThemeMode changetheme({ThemeMode? th}) {
    if (th != null) {
      theme = th;
    } else if (theme == ThemeMode.dark) {
      theme = ThemeMode.light;
    } else {
      theme = ThemeMode.dark;
    }
    emit(ChangeTheme(theme: theme));
    return theme;
  }
}
