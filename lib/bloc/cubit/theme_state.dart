part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ChangeTheme extends ThemeState {
  final ThemeMode theme;

  ChangeTheme({required this.theme});
}
