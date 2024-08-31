import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme();
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);
  
}
