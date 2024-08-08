part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  final ThemeMode th;

  ThemeInitial({required this.th});
}

final class ChangeTheme extends ThemeState {
  final ThemeMode theme;

  ChangeTheme({required this.theme});
}

final class IsFirstRun extends ThemeState {
  final bool isFirstRun;

  IsFirstRun({required this.isFirstRun});
}
