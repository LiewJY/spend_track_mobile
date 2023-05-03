import 'package:flutter/material.dart';
import 'package:track/theme/app_color.dart';

class AppTheme {
  static ThemeData lightThemeData = themeData(lightColorScheme);
  static ThemeData darkThemeData = themeData(darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      //textTheme: _textTheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      //highlightColor: Colors.transparent,
      //focusColor: focusColor,

      //input field --> text, & others
      inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          errorStyle: TextStyle(color: colorScheme.error)
      )
      
      




    );
  }
}

ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(AppColors.primary.get(40)),
  onPrimary: Color(AppColors.primary.get(100)),
  primaryContainer: Color(AppColors.primary.get(90)),
  onPrimaryContainer: Color(AppColors.primary.get(10)),
  secondary: Color(AppColors.secondary.get(40)),
  onSecondary: Color(AppColors.secondary.get(100)),
  secondaryContainer: Color(AppColors.secondary.get(90)),
  onSecondaryContainer: Color(AppColors.secondary.get(10)),
  tertiary: Color(AppColors.tertiary.get(40)),
  onTertiary: Color(AppColors.tertiary.get(100)),
  tertiaryContainer: Color(AppColors.tertiary.get(90)),
  onTertiaryContainer: Color(AppColors.tertiary.get(10)),
  error: Color(AppColors.error.get(40)),
  onError: Color(AppColors.error.get(100)),
  errorContainer: Color(AppColors.error.get(90)),
  onErrorContainer: Color(AppColors.error.get(10)),
  background: Colors.white,
  onBackground: Colors.black,
  surface: Color(AppColors.neutral.get(98)),
  onSurface: Color(AppColors.neutral.get(10)),
  onSurfaceVariant: Color(AppColors.neutralVariant.get(30)),
  outline: Color(AppColors.neutralVariant.get(30)),
  outlineVariant: Color(AppColors.neutralVariant.get(80)),
  shadow: Color(AppColors.neutral.get(0)),
  scrim: Color(AppColors.neutral.get(0)),
  inverseSurface: Color(AppColors.neutral.get(20)),
  onInverseSurface: Color(AppColors.neutral.get(95)),
  inversePrimary: Color(AppColors.primary.get(80)),
);

ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(AppColors.primary.get(80)),
  onPrimary: Color(AppColors.primary.get(20)),
  primaryContainer: Color(AppColors.primary.get(30)),
  onPrimaryContainer: Color(AppColors.primary.get(90)),
  secondary: Color(AppColors.secondary.get(80)),
  onSecondary: Color(AppColors.secondary.get(20)),
  secondaryContainer: Color(AppColors.secondary.get(30)),
  onSecondaryContainer: Color(AppColors.secondary.get(90)),
  tertiary: Color(AppColors.tertiary.get(80)),
  onTertiary: Color(AppColors.tertiary.get(20)),
  tertiaryContainer: Color(AppColors.tertiary.get(30)),
  onTertiaryContainer: Color(AppColors.tertiary.get(90)),
  error: Color(AppColors.error.get(80)),
  onError: Color(AppColors.error.get(80)),
  errorContainer: Color(AppColors.error.get(30)),
  onErrorContainer: Color(AppColors.error.get(90)),
  background: Colors.black,
  onBackground: Colors.white,
  surface: Color(AppColors.neutral.get(6)),
  onSurface: Color(AppColors.neutral.get(90)),
  onSurfaceVariant: Color(AppColors.neutralVariant.get(80)),
  outline: Color(AppColors.neutralVariant.get(60)),
  outlineVariant: Color(AppColors.neutralVariant.get(30)),
  shadow: Color(AppColors.neutral.get(0)),
  scrim: Color(AppColors.neutral.get(0)),
  inverseSurface: Color(AppColors.neutral.get(20)),
  onInverseSurface: Color(AppColors.neutral.get(95)),
  inversePrimary: Color(AppColors.primary.get(80)),
);
