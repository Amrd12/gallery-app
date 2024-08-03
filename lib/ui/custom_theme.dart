import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTheme {
  CustomTheme();
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);
  
}
