part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  final ThemeMode th;
  final Locale lo;

  ThemeInitial({required this.th, required this.lo});
}

final class ChangeTheme extends ThemeState {
  final ThemeMode theme;

  ChangeTheme({required this.theme});
}

final class ChangeLocale extends ThemeState {
  final Locale locale;

  ChangeLocale({required this.locale});
}

final class IsFirstRun extends ThemeState {
  final bool isFirstRun;

  IsFirstRun({required this.isFirstRun});
}
