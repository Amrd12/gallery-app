part of 'theme_cubit.dart';

sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ChangeTheme extends ThemeState {
  final ThemeMode theme;

  ChangeTheme({required this.theme});
}

final class IsFirstRun extends ThemeState {
  final bool isFirstRun;

  IsFirstRun({required this.isFirstRun});
}
